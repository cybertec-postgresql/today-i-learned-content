---
date: 2019-10-17
title: List unpushed commits
author: lorenz.henk@cybertec.at
tags: ["git", "log", "commit", "unpushed"] # max. 10 tags; lowercase; dash-separated
description: "How to list all unpushed git commits" # max. 300 chars.
---

This one-liner will list all unpushed commits across all branches:

```sh
git log --branches --not --remotes
```
