---
date: 2019-09-07
title: Install Docker on Fedora 29+
author: lorenz.henk@cybertec.at
tags: ["docker", "fedora"] # max. 10 tags; lowercase; dash-separated
description: "How to install Docker through Fedora repositories" # max. 300 chars.
---

Docker can be installed through Fedora's standard repos, but it was renamed to `moby-engine`.

It can be installed with `dnf install moby-engine`.

See [this issue](https://github.com/docker/for-linux/issues/511#issuecomment-449535149) for more information.
