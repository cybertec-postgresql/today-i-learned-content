---
date: 2030-12-31 # Auto updates on publish.
title: Configure fail2ban with Cloudflare DNS
author: lorenz.henk@cybertec.at
tags: ["f2b", "fail2ban", "cloudflare", "dns", "whitelist", "ignoreip", "521"] # max. 10 tags; lowercase; dash-separated
description: "How to make fail2ban work with Cloudflare" # max. 300 chars.
---

If you're using Cloudflare as your DNS provider and proxy and want to use fail2ban to
secure your website, you must be careful not to block Cloudflare IPs.

If fail2ban blocks Cloudflare, your website can't be proxied through Cloudflare
leading to a 521 website down error.

To fix this problem you'll have to add [these IPs](https://www.cloudflare.com/ips/)
to your fail2ban whitelist config.

The whitelist is located at `/etc/fail2ban/jail.conf` in the `ignoreip` property.

Write all IPs separated by space.

Example for the current IPs:

```
ignoreip = 127.0.0.1/8 ::1 173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/12 172.64.0.0/13 131.0.72.0/22 2400:cb00::/32 2606:4700::/32 2803:f800::/32 2405:b500::/32 2405:8100::/32 2a06:98c0::/29 2c0f:f248::/32
```
