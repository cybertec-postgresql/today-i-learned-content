---
date: 2019-10-24
title: Change default shell for new users
author: lorenz.henk@cybertec.at
tags: ["useradd", "shell", "user", "default"] # max. 10 tags; lowercase; dash-separated
description: "See how you can easily change the useradd default settings" # max. 300 chars.
---

If you have a system with lots of new users, you probably want to set the default shell to the one that most users prefer.

If you're using the `useradd` command, you can set default options in the file `/etc/default/useradd`.

Editing this file can be done by using `useradd -D ...`:

```bash
# set default shell for new users to bash
useradd -D -s /bin/bash
```

Check [here](http://manpages.ubuntu.com/manpages/bionic/de/man8/useradd.8.html) for more information.
