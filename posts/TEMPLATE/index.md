---
date: 2030-12-31 # Auto updates on publish.
title: Initialize docker volume with container data
author: lorenz.henk@cybertec.at
tags: ["docker", "volume", "storage", "copy", "data"] # max. 10 tags; lowercase; dash-separated
description: "How to initialize a volume with docker container data" # max. 300 chars.
---

A docker volume can be initialized with data from a container:

```bash
docker run \
  -v volume-name:/usr/share/nginx/html \
  nginx:latest
```

This creates a new volume named `volume-name` and initializes it with the data from `/usr/share/nginx/html`.

See [the docker docs](https://docs.docker.com/storage/volumes/#populate-a-volume-using-a-container) for more information.

### Pitfalls

#### Only empty volumes

This does only work for **empty volumes**. A volume is empty if it has not been used yet.
If a volume with the given name does not exist yet, it is created.

#### Can't set path

You cannot set a custom path for the volume.
If you use `-v /my/path:/usr/share/nginx/html`, the destination in the container will be overlayed.
