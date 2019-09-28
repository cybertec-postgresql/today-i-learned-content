---
date: 2019-9-28
title: Git add partial files
author: lorenz.henk@cybertec.at
tags: ["git", "git-add", "parameter"] # max. 10 tags; lowercase; dash-separated
description: "Do you know git add -p? If not, read on" # max. 300 chars.
---

I often write lots of code at once and forget to commit.
Then I have to create one huge commit with all changes,
because I thought I can't partially stage and commit a file.

Turns out, you can do exactly that with `git add -p`!

This command lets you interactively select which `hunks` (blocks of changes)
you want to stage.

