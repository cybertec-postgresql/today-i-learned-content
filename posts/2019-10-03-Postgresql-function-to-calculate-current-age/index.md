---
date: 2019-10-03
title: Postgresql function to calculate current age
author: lorenz.henk@cybertec.at
tags: ["postgresql", "timestamp", "age", "function"] # max. 10 tags; lowercase; dash-separated
description: "Need to calculate / verify ages in PostgreSQL? No problem with the age function!" # max. 300 chars.
---

PostgreSQL includes many useful utility functions. One of those is the `age` function.

```sql
SELECT age(timestamp '1999-06-20');
```

```
           age
-------------------------
 20 years 3 mons 13 days
```
