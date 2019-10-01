---
date: 2019-010-01
title: Quickly test whether ports can be reached on your linux machine
author: julian.markwort@cybertec.at
tags: ["firewall", "linux", "netcat", "nc", "ports", "testing", "probe", "listening address"] # max. 10 tags; lowercase; dash-separated
description: "How would you quickly check if a given port is reachable on your system or not, so you can go complain to the network admins? I'll show you my way." # max. 300 chars.
---

If you've ever tried to launch anything that opens a port on your linux machine and you'd like to know whether you've misconfigured something (e.g. the listen address), or whether you're running into firewall issues, you'll be grateful to find out that there's a simple way to test for firewall issues.

There's a tool called `netcat`; It's part of almost any linux server setup I've worked on and it can be launched by typing `nc` on your command line.
`netcat` has two modes:
- a calling mode
- a listening mode

We can use both of these, on two sides of our server to check if the firewall will let us pass or not.

## Introduction to `netcat`

On the machine where you'd like to run the server, which will be listen on a given port, say `54321`, run this to open a listening `netcat`:
```
nc -vlk 54321
```
I'll break those arguments down for you:
- `v` is for verbose: print more details about connections
- `l` is for listening mode
- `k` is for keep-open; This means that `netcat` will accept connections over and over again.
- `54321` is for the listening port. By default, `netcat` listens on all IP-addresses it can find, but you can also limit it to a given IP-address, say your primary IP-address, so your service can be reached from your network, but not via localhost, for example.


You can stop `netcat` by sending an interrupt signal (<kbd>Ctrl</kbd> + <kbd>c</kbd>).

Now, on the second machine, we'll launch another `netcat` instance, which is set to connect to the first machine, by IP-address (or even hostname) and by port:
```
nc -vz 192.168.178.24 54321
```
Here, the arguments have the following meaning:
- `v` is still for verbose
- `z` is for Zero-I/O mode, meaning that `netcat` will initiate a connection and report success or failure, but won't transmit any data
- `192.168.178.24` is my first machine's local IP-address
- `54321` is the port that we'd like to connect to.

> Please be aware that it's impossible to bind two applications to the same port. So as long as you have a `netcat` running that listens on port `54321`, trying to launch another application that should listen on `54321` will fail. If in doubt, run `sudo killall nc` to kill all netcats that may still be running in the background (If you launched the netcats detached, by adding a postfix ` &` to your `nc` call).

## Do some testing

If you now run these two commands in different terminals, it might look like this:

1. Open the port

```
[julian@linux1 ~]$ nc -vlk 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::54321
Ncat: Listening on 0.0.0.0:54321
```
> Note, that `netcat` now is listening on all IPv6 addresses (`::` is an IPv6 address wildcard) and all IPv4 addresses (`0.0.0.0` is an IPv4 wildcard) registered on your system.

2. Try to reach it

```
[julian@linux2 ~]$ nc -vz 192.168.178.24 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connected to 192.168.178.24:54321.
Ncat: 0 bytes sent, 0 bytes received in 0.01 seconds.
```

3. Now, your first terminal will show this:

```
[julian@linux1 ~]$ nc -vlk 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::54321
Ncat: Listening on 0.0.0.0:54321
Ncat: Connection from 192.168.178.25.
Ncat: Connection from 192.168.178.25:60842.
```

In this scenario, we succeeded with our testing. The port is open and if I now try to make my application available from my own network, I'll only have to troubleshoot the application itself and the configured listening address.

If a firewall was running that prevents my system from accepting connections through the specific port, I'd get something like this, and no new lines from the command on my first system:

```
[julian@linux2 ~]$ nc -vz 192.168.178.24 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connection refused.
```


You can also go ahead and experiment with `netcat` and learn something about how listening addresses work:
run `nc -vlk 127.0.0.1 54321` and `nc -vz 192.168.178.24 54321` or `nc -vlk 192.168.178.24 54321` and `nc -vz 127.0.0.1 54321`. Try what happens if you swap the IP-addresses around (Of course, you need to replace my IP-address with your own.).

Also, try what happens if you use the wrong wildcard: `nc -vlk :: 54321` or `nc -vlk 0.0.0.0 54321`. In the former case, you'll only be able to connect to your machine via IPv6. In the latter case, you can only use IPv4 connections.
You could then reach it via a hostname and tell the connecting `netcat` to only use IPv4 or IPv6 connections: `nc -vz6 hostname 54321` and `nc -vz4 hostname 54321`

```
[julian@linux1 ~]$ nc -vlk :: 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Listening on :::54321
Ncat: Connection from 2003:dd:ff2f:d800:f4aa:8a99:f084:ee31.
Ncat: Connection from 2003:dd:ff2f:d800:f4aa:8a99:f084:ee31:53090.
```

```
[julian@linux2 ~]$ nc -vz6 linux1 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connected to 2003:dd:ff2f:d800:f4aa:8a99:f084:dd41:54321.
Ncat: 0 bytes sent, 0 bytes received in 0.02 seconds.
```

```
[julian@linux2 ~]$ nc -vz4 linux1 54321
Ncat: Version 7.70 ( https://nmap.org/ncat )
Ncat: Connection refused.
```
