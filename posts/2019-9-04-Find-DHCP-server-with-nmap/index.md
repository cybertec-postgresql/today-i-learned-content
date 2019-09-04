---
date: 2019-9-04
title: Find DHCP server with nmap
author: lorenz.henk@cybertec.at
tags: ["dhcp", "nmap", "broadcast"] # max. 10 tags; lowercase; dash-separated
description: "Wondering where those unwanted IP addresses are leased from? Here's some help" # max. 300 chars.
---
#### TL;DR

Unknown DHCP Server in your network?
[`sudo nmap --script broadcast-dhcp-discover`](https://nmap.org/nsedoc/scripts/broadcast-dhcp-discover.html)

#### Story time

You enter the office like every morning, go upstairs and suddenly 3 Sales-colleges shout at you - the Internet is down.

You sit down next to one of their PCs and start debugging.\
You see the PC got an IP address - `192.168.88.54`.\
Wait a second - our router is configured for the network `192.168.0.0/24`!\
What's going on here?\
You start your own PC - same thing.

First of all, you set static IP addresses for the correct network on all PCs - they can reach the outside world again, and your co-workers can continue working.

Next step: You need to find out where the `.88.*`-IPs come from.

Thankfully, there is a nice [`nmap` script](https://nmap.org/nsedoc/scripts/broadcast-dhcp-discover.html) for that:
```bash
$ sudo nmap --script broadcast-dhcp-discover

Pre-scan script results:
| broadcast-dhcp-discover:
|   Response 1 of 1:
|     IP Offered: 192.168.88.133
|     DHCP Message Type: DHCPOFFER
|     Server Identifier: 192.168.0.208
|     IP Address Lease Time: 10m00s
|     Subnet Mask: 255.255.255.0
|     Router: 192.168.88.1

Service Info: Host: the_office; OSs: Linux, RouterOS; Device: router; CPE: cpe:/o:mikrotik:routeros, cpe:/o:linux:linux_kernel
```

"We don't have any `MikroTik` products in our office", you think.

You do an image search for `MikroTik` routers on your phone and wander around in the office to find a similar-looking small box.

Half an hour later, you find it under someones desk, burried between ethernet cables. You remove it from the network and *voila*, everyone gets IP addresses from the correct DHCP server again.

Later you find out, that one of your co-workers wanted to add a switch to the network to expand the available ethernet ports. In a misunderstanding, they added a router instead.

Thanks to you (and [this handy script](https://nmap.org/nsedoc/scripts/broadcast-dhcp-discover.html)), the internet is saved and you can finally start your working day.
