---
date: 2030-12-31 # Auto updates on publish.
title: Managing etcd users and roles from Ansible
author: julian.markwort@cybertec.at
tags: ["ansible", "etcd", "users", "roles", "password", "expect", "etcdctl", "curl", "json"] # max. 10 tags; lowercase; dash-separated
description: "Good Security in etcd starts with the provisioning of users. Unfortunately, the etcd module for Ansible can only be used to interact with the k/v-store of etcd, it can't manage users. But we can do without it, by using the URI module to send http requests." # max. 300 chars.
---

Recently, I was tasked with creating a bunch of Patroni clusters.
In this setup, all members of each cluster write health info into a DCS, usually etcd. etcd is also used to infer a decision in the leader race; The member that succeeds at creating the leader key in the key/value-store (_k/v-store_) can promote its database.

To make sure that nobody can write malicious data to the k/v-store of the etcd that Patroni uses, you should always use dedicated users and roles for etcd access.

To further limit the vulnerability of all your Patroni clusters in case a single cluster is compromised, it is advisable to create a user and a corresponding role for each Patroni cluster, making sure that the users are only allowed to write to the namespace that belongs to their cluster.

### user and role management in etcd

By default, an etcd cluster does not use any authentication -- every client can do anything.
Each user needs to be created with a password. (Unlike PostgreSQL, for example, which allows you to have users/roles without passwords.)
Roles in etcd serve the purpose of managing permissions, primarily by limiting the areas of the k/v-store into which someone can write, or what they can read.

### enable authentication in etcd

After adding a user called _root_:
```bash
[root@centos-server-101 ~]# etcdctl user add root:snakeoil
User root created
```
you can turn on authentication:
```bash
[root@centos-server-101 ~]# etcdctl auth enable
Authentication Enabled
```

As you see, the _root_ user is able to read/write everything in the k/v-store, beginning from the root directory:
```bash
[root@centos-server-101 ~]# etcdctl -u root:snakeoil role get root
Role: root
KV Read:
	/*
KV Write:
	/*
```

But despite enabling authentication, you're still allowed, without any authentication, to read and write keys.
By default (or rather by bad design), there exists a guest role for unauthenticated users and this role can still do everything:
```bash
[root@centos-server-101 ~]# etcdctl -u root:snakeoil role get guest
Role: guest
KV Read:
	/*
KV Write:
	/*
```

So let's drop this really bad design decision:
```bash
[root@centos-server-101 ~]# etcdctl -u root:snakeoil role remove guest
Role guest removed
```

Now, you've created a problem: No one can create keys or manipulate values, unless you add more users and roles and tell the clients about the credentials.


### role requirements for Patroni clusters

Fortunately, the way Patroni uses k/v-stores already relies on some sort of directory structure, so it's pretty straight-forward to create roles that only allow access to a certain cluster's directories.
In the beggining of a Patroni config file you'll usually find these two lines:
```yaml
scope: batman
namespace: /service/
```
What's defined as the `scope` is usually referred to as the _cluster name_.

Now, all read and write operations sent from Patroni to the k/v-store only use stuff contained in the directory `/service/batman/`.

So let's generate a user and a matching role for our _batman_ Patroni cluster:
```bash
etcdctl -u root:snakeoil role add patroni_role
etcdctl -u root:snakeoil role grant patroni_role --readwrite --path '/service/batman/*'
etcdctl -u root:snakeoil user add patroni:moresnakeoil
etcdctl -u root:snakeoil user grant patroni --roles patroni_role
```
This will give us the following:
```bash
[root@centos-server-101 ~]# etcdctl -u root:snakeoil role get patroni_role
Role: patroni_role
KV Read:
	/service/batman/*
KV Write:
	/service/batman/*
```

So now you only need to add the username and password to your Patroni config files and you can be sure that the compromise of the server containing this Patroni cluster does not automatically grant access to the namespaces of other Patroni clusters that use the same etcd.


## Adding many users and roles with Ansible
Of course, no one wants to run those commands to create users, roles, grant the roles to the users and define the permissions for the roles for each Patroni cluster manually.

So I thought to myself: let's use Ansible to automate this repetive, boring task.
Unfortunately, the etcd module for Ansible can only be used to interact with the k/v-store of etcd, it cannot manage users nor roles.

Calling etcdctl from within Ansible itself is also not a good idea. You'd either need a current enough version of `python-expect` to answer the password prompt during user creation and everytime you do something as user root, or you'll have to write the password into a command that Ansible will run in a shell, thus presenting your passwords to anyone who can see the processes on your hosts, as well as anyone who has access to the bash history or some other logging method present on your system.

The last option, but by far not a bad one, is to send HTTP requests to your etcd cluster, to manage users and roles.
This provides us with an option of interacting with etcd without presenting the password to other users on the destination system. Of course, anyone who's able to eavesdrop on your network might be able to intercept unencrypted messages; So it's a good idea to use etcd with TLS, but that topic is already covered elsewhere.

Ansible provides the URI module which we can use to send HTTP messages of our own description.
There is an etcd API v2 reference with documentation of all endpoints, data formats and status codes over on [github](https://github.com/etcd-io/etcd/blob/master/Documentation/v2/auth_api.md).


My Ansible environment consists of a hosts file that, among others contains a list of the members of the etcd cluster. There are also some variables and definitions in a local directory called `vars/`; This is where variables like `etcd_client_port` or `etcd_patroni_user` come from.

Let's start writing the playbook:
```yaml
- hosts: etcd
  become: true

  tasks:
  - include_vars:
      dir: vars/

  - run_once: true
    block:
    - name: get user list
      run_once: true
      uri:
        url: "http://{{ansible_hostname}}:{{etcd_client_port}}/v2/auth/users"
        method: GET
        force_basic_auth: yes
        url_username: root
        url_password: "{{etcd_root_password}}"
      register: etcd_user_list

    - name: print out list
      debug:
        var: etcd_user_list.json
```
All tasks in this playbook will be contained in the `block` to make sure all commands are only run once.
Otherwise, every member of my `etcd` hosts list would try to add users simultaneously.

Running this playbook gives us the follwing output:
```bash
[julian@linux ansible]$ ansible-playbook etcd_user_add_test.yml -i misc/centoshosts-pgcluster

PLAY [etcd] *********************************************************************************

TASK [include_vars] *************************************************************************
ok: [192.168.178.37]
ok: [192.168.178.35]
ok: [192.168.178.36]

TASK [get user list] ************************************************************************
ok: [192.168.178.37]

TASK [print out list] ***********************************************************************
ok: [192.168.178.37] => {
    "etcd_user_list.json": {
        "users": [
            {
                "roles": [
                    {
                        "permissions": {
                            "kv": {
                                "read": [
                                    "/*"
                                ],
                                "write": [
                                    "/*"
                                ]
                            }
                        },
                        "role": "root"
                    }
                ],
                "user": "root"
            }
        ]
    }
}
```

Here's a task that adds users, this is still pretty straight-forward:

```yaml
    - name: add etcd user "{{etcd_patroni_user}}" via uri module
      uri:
        url: "http://{{ansible_hostname}}:{{etcd_client_port}}/v2/auth/users/{{etcd_patroni_user}}"
        method: PUT
        force_basic_auth: yes
        url_username: root
        url_password: "{{etcd_root_password}}"
        body:
          user: "{{etcd_patroni_user}}"
          password: "{{etcd_patroni_password}}"
        body_format: json
        status_code: 201, 200
      register: response
      changed_when: response.status == 201
```
We can make use of the URI module's `body_format: json` so we can simply specify the contents of the message body by writing easily readable YAML and having the module convert it to JSON automatically.

201 is the status code for "the user was succesfully added" and 200 is for "the user is already present". It is important to accept both of these status codes, as Ansible playbooks should always be idempotent, i.e. the outcome of running the playbook multiple times should not be different from running it only once.
But since the user for this Patroni did not exist in my case, the outcome of the task is presented as `changed`:
```bash
TASK [add etcd user "patroni" via uri module] ***********************************************
changed: [192.168.178.37]
```

However, things are becoming more difficult once we try to create roles.
Sending a HTTP request to `PUT` a new role once works fine, you'll get a status code 201 and everything is good. But, remember the idempotency aspect of playbooks. Sending that very same HTTP request another time will result in a status code 409, which means that etcd thinks there was a conflict in the permissions. It does not actually check to see if there is a way to resolve the conflict, it simply gives up.
So it is on us to make sure that the role we are trying to create is not already present:

```yaml
    - name: check if role is already present and covers the expected directories
      uri:
        url: "http://{{ansible_hostname}}:{{etcd_client_port}}/v2/auth/roles/{{etcd_patroni_user}}"
        method: GET
        force_basic_auth: yes
        url_username: root
        url_password: "{{etcd_root_password}}"
        return_content: yes
      register: etcd_role
	  failed_when: false
```
If this call results in a HTTP status code 200, the registered result will contain the permissions that are already set for the `{{etcd_patroni_user}}` role.
Anything other than 200 means that there is no such role present (or that etcd was offline or that we're not allowed to look at the roles, but in that case, the earlier tasks would have already failed.)
Regardless of the result, we want to continue -- that's why this task is marked such that it will never be considered failed.

So, having gathered some information regarding the presence of the role, we can check to see if the permissions match what Patroni would need:
```yaml
    - name: check permissions for correctness if already present
      set_fact:
        read_permissions_present: "{{false if (etcd_role.status != 200) else (etcd_role.json.permissions.kv.read[0] == (patroni_namespace+patroni_cluster_name+'/*'))}}"
        write_permissions_present: "{{false if (etcd_role.status != 200) else (etcd_role.json.permissions.kv.write[0] == (patroni_namespace+patroni_cluster_name+'/*'))}}"
```
Both read and write permissions are considered not present if the status call of the previous call was not 200.
Otherwise, we compare the appropriate fields from the json response (returned from the uri call above because we specified `return_content: yes`) to the expected value.

The last thing to do then is the actual creation of the roles, but only if the permissions are not already present.
```yaml
    - debug:
        var: read_permissions_present
    - debug:
        var: write_permissions_present

	- name: add etcd role "{{etcd_patroni_user}}" via uri module
      when: (not read_permissions_present) or (not write_permissions_present)
      uri:
        url: "http://{{ansible_hostname}}:{{etcd_client_port}}/v2/auth/roles/{{etcd_patroni_user}}"
        method: PUT
        force_basic_auth: yes
        url_username: root
        url_password: "{{etcd_root_password}}"
        body:
          role: "{{etcd_patroni_user}}"
          permissions:
            kv:
              read:
              #assuming patroni_namespace starts and ends with /
              - "{{patroni_namespace}}{{patroni_cluster_name}}/*"
              write:
              - "{{patroni_namespace}}{{patroni_cluster_name}}/*"
        body_format: json
        status_code: 201, 200
      register: response
      changed_when: response.status == 201
```
If the roles where not present, or did not match our expectation, the task will be executed and will probably fail due to the aforementioned permission conflicts. But that would be something that needs user intervention anyway.

The first execution of the last task then gives the following result:
```bash
TASK [debug] ********************************************************************************
ok: [192.168.178.37] => {
    "read_permissions_present": false
}

TASK [debug] ********************************************************************************
ok: [192.168.178.37] => {
    "write_permissions_present": false
}

TASK [add etcd role "patroni" via uri module] ***********************************************
changed: [192.168.178.37]
```

Any subsequent executions of this task for the same `{{etcd_patroni_user}}` will result in the skipping of the task, as the permissions are already correct:
```bash
TASK [debug] ********************************************************************************
ok: [192.168.178.37] => {
    "read_permissions_present": true
}

TASK [debug] ********************************************************************************
ok: [192.168.178.37] => {
    "write_permissions_present": true
}

TASK [add etcd role "patroni" via uri module] ***********************************************
skipping: [192.168.178.37]
```


Now, let's check if we were successfull:
```
    - name: get role list
      uri:
        url: "http://{{ansible_hostname}}:{{etcd_client_port}}/v2/auth/roles"
        method: GET
        force_basic_auth: yes
        url_username: root
        url_password: "{{etcd_root_password}}"
      register: etcd_user_list

    - name: print out list
      debug:
        var: etcd_user_list.json
```
Which gives us:
```bash
TASK [get role list] *****************************************************************************************************************************************
ok: [192.168.178.37]

TASK [print out list] ****************************************************************************************************************************************
ok: [192.168.178.37] => {
    "etcd_user_list.json": {
        "roles": [
            {
                "permissions": {
                    "kv": {
                        "read": [
                            "/service/pgcluster/*"
                        ],
                        "write": [
                            "/service/pgcluster/*"
                        ]
                    }
                },
                "role": "patroni"
            },
            {
                "permissions": {
                    "kv": {
                        "read": [
                            "/*"
                        ],
                        "write": [
                            "/*"
                        ]
                    }
                },
                "role": "root"
            }
        ]
    }
}
```
Splendid!


Now, a final thing to consider: The role checking only tests if the first (of possibly many) permissions has the correct form. For Patroni, only the read and write permissions for one directory and everything inside that are relevant. But other applications might require more permissions, which is why the `kv` field of the permissions is a JSON list; So you may need to think something up that can iterate over the permission list...

I really enjoy solving problems like these with Ansible.
Everything is possible, nothing is forbidden, but some solutions are not elegant; For example, calling `etcdctl` using the _command_ module, which will indirectly publish the passwords contained in the command to several files, daemons and the process stack on your destination hosts.