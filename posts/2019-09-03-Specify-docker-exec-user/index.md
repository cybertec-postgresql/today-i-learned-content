---
date: 2019-09-03
title: Specify docker exec user
author: lorenz.henk@cybertec.at
tags: ["docker", "exec", "user"] # max. 10 tags; lowercase; dash-separated
description: "Set the user context for docker exec commands" # max. 300 chars.
---

With `docker exec`, you can execute commands inside of running Docker containers.
The `--user` flag allows you to declare the user to use inside the container.

Example:
```bash
$ docker run -d
cf4bea1aa03eafc0a4adf49cc1f38e98de66ab586cbf026d369de2d51f83fbc3
$ docker exec -it --user postgres cf4bea1a /bin/bash
postgres@cf4bea1aa03e:/$
```
