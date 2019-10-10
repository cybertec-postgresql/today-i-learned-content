---
date: 2019-10-10
title: "`diff.orderFile`: order your `git diff` output smart!"
author: pavlo.golub@cybertec.at
tags: ["git", "diff", "development", "postgresql"] # max. 10 tags; lowercase; dash-separated
description: "Trick to make git diff ouput more comfortable" # max. 300 chars.
---

Working on a project, you might consider that one folder is more important than others. For example, `src` folder might be more relevant to you as a developer than `doc`, `test`, or `samples`, you name it. Or you may want source files to be listed first, e.g. `*.c`, `*.go`...

To order the list of files in `git diff` output, one may use [git's diff.orderFile option](https://git-scm.com/docs/git-config#Documentation/git-config.txt-difforderFile).

If you are working with PostgreSQL for example, you may want such an [order](https://twitter.com/AndresFreundTec/status/1180513519852146688):
```
src/include/* 
src/common/* 
src/port/* 
config/* 
src/makefiles/* 
src/template/* 
src/backend/* 
src/fe_utils/* 
src/bin/* 
src/interfaces/libpq/* 
src/pl/* 
contrib/* 
src/interfaces/* 
doc/* 
src/test/*
```

To achieve this:
- create a file with the proper list, e.g. `.gitorderfile`
- run `git config diff.orderFile .gitorderfile`

You're done!
