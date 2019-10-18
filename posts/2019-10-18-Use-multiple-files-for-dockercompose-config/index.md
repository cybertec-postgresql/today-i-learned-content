---
date: 2019-10-18
title: Use multiple files for docker-compose config
author: lorenz.henk@cybertec.at
tags: ["docker-compose", "config"] # max. 10 tags; lowercase; dash-separated
description: "" # max. 300 chars.
---

You can specify one or multiple config files for `docker-compose` with the `-f` flag:

```bash
# one file
docker-compose -f docker-compose.yml up -d
# multiple files
docker-compose -f docker-compose.yml -f docker-compose.tests.yml up -d
```

Be sure to specify the config files _before_ the sub-command:

```bash
# invalid
docker-compose ps -f docker-compose.yml
# valid
docker-compose -f docker-compose.yml ps
```
