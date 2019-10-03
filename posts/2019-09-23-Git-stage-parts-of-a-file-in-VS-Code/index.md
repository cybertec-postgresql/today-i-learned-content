---
date: 2019-09-23
title: Git stage parts of a file in VS Code
author: lorenz.henk@cybertec.at
tags: ["vs-code", "git", "stage", "range", "selected"] # max. 10 tags; lowercase; dash-separated
description: "This post explains how to partially stage a file in VS Code" # max. 300 chars.
---

With VS Code, you can interactively select which parts of a file should be staged:
1) Make changes to a file that is managed with git
2) Go to the `Working Tree` view of that file
3) Select the lines you want to stage and click the *right* mouse button
![Diff view](./diff.png)
4) Click `Stage Selected Ranges`
![Menu](./menu.png)


Additionally, you can also **unstage** or **revert** the selected changes.
