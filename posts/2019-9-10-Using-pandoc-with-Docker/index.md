---
date: 2019-9-10
title: Using pandoc with Docker
author: lorenz.henk@cybertec.at
tags: ["docker", "pandoc", "latex"] # max. 10 tags; lowercase; dash-separated
description: "How to use a Docker image with pandoc" # max. 300 chars.
---

Nobody likes installing the whole Latex toolchain to convert your documents with `pandoc`.

Docker to the rescue!

```bash
docker run -v $(pwd):/source jagregory/pandoc -t beamer presentation.md presentation.pdf
```

Check out [this repository](https://github.com/jagregory/pandoc-docker) for more information!
