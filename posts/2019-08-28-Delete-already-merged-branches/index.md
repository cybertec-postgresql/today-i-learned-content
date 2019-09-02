---
date: 2019-08-28
title: Delete already merged branches
author: lorenz.henk@cybertec.at
tags: ["git", "merge", "branch"]
description: "Small command to delete already merged branches"
---

The code example below shows how to delete all branches which have already been merged into the current branch:

```bash
$ git branch
  feature-1
  feature-2
  feature-3
* master

$ git branch --merged
  feature-1
* master

$ git branch --merged | egrep -v "(^\*|master)"
  feature-1

$ git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d
Deleted branch feature-1 (was 1d7fd54).
```

Check out this great [stackoverflow answer](https://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-have-been-merged/6127884#6127884) for more information.
