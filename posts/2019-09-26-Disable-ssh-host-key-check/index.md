---
date: 2019-09-26
title: Disable ssh host key check
author: lorenz.henk@cybertec.at
tags: ["ssh", "host-key", "automation", "security"] # max. 10 tags; lowercase; dash-separated
description: "Don't care about host authenticity? Check out this tip for ssh automation!" # max. 300 chars.
---

When automating a task, there's nothing more annoying than an "are you sure?"-question popping up.

If you want to automate an `ssh` connection,
chances are this is the first time you're connecting to your target.
Thus, you'll be presented with the following message:

```
$ ssh example.com
The authenticity of host 'example.com (...)' can't be established.
RSA key fingerprint is SHA256:P2VbGDRAAaPQTaBovKynIccHxse4aXNH0ZgGLyVTzQL.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

This check can be turned off with the `StrictHostKeyChecking` option:

```bash
$ ssh -o StrictHostKeyChecking=no example.com
```

**Caution**: This is a security check to mitigate different attacks.
Only turn this feature off if you understand the risks.
