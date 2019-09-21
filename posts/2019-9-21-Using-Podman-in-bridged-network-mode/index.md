---
date: 2019-9-21
title: Using Podman in bridged network mode
author: julian.markwort@cybertec.at
tags: ["podman", "network-bridge", "bridged-ip-address", "docker", "slirp4netns"] # max. 10 tags; lowercase; dash-separated
description: "Opening ports in Podman is simple: add a -p or --publish to your podman run command and specify which ports to direct where and you're off. But what if you want your container to be reachable from your host by IP address?" # max. 300 chars.
---

Podman is really great for those of us who don't want the Docker daemon running in the background all the time.

It is mostly compatible with Dockerfiles and Docker CLI syntax (as far as I've read online and noticed, while poking at both of them), but some things are handled differently due to the nature of Podman's daemonless architecture.

I was trying to create a couple of Docker containers with IP addresses so I could test some Ansible scripts.
I have to make sure the scripts work for different distributions and different versions of those distributions and managing virtual machines (or even clusters of those) in VirtualBox can become a bit frustrating.

So for Ansible, I usually need hostnames or IP addresses to define against which hosts my playbooks are run.
But whenever I was running containers, they didn't have IP addresses:
```
[julian@localhost ansible]$ podman run -dit --name centos1 centos:7
faf5abe92901c4757982bbcb39f0a89800e7378358fff88908bea09161922282
[julian@localhost ansible]$ podman inspect centos1 | grep -i ipaddress
            "SecondaryIPAddresses": null,
            "IPAddress": "",
```

Of course, I could open up ports by publishing them with the -p flag, but that won't help me to use Ansible.

#### Google to the rescue??

Googling turned up no helpful advice, I saw that the `--net host` option is dangerous and should be used with caution, but no help on bridged networking, as I know it from VirtualBox.

After reading the [docs](https://github.com/containers/libpod/blob/master/docs/podman-run.1.md) on `podman run`, I figured it out: if you're running Podman without root, it can only use the network mode `slirp4netns`, which will create an isolated network stack so that you can connect to the internet from the inside of your container and bind certain ports of your container to the user-bindable ports on you host, but nothing more.

To be able to select the network mode `bridged`, which does exactly what I need, you'll have to run Podman as root. It turns out that the bridged mode is the default for running Podman as root.

Now, to further streamline my Ansible testing procedure, I can even specify which IP address should be used by the container:

```
[julian@localhost ansible]$ sudo podman run -dit --ip 10.88.0.42 --name centos3 centos:7
3b56ae068a628027c7d8815485022f6cb59c7aa5d26e6bf4137961ecb6307952
[julian@localhost ansible]$ sudo podman inspect centos3 | grep -i ipaddress
            "SecondaryIPAddresses": null,
            "IPAddress": "10.88.0.42",
```

And of course, I can now reach any ports I open in the container via this IP address.

Note however, that these containers can only be reached from your own machine, via the bridge interface usually called `cni0`, which is created by Podman.
To access the containers by IP from other machines in your network, you'd need to bridge them to the `10.88.0.1/16` subnet somehow... But that will have to wait for another *TIL* for another day...
