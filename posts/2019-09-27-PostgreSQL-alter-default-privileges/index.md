---
date: 2019-09-27
title: PostgreSQL alter default privileges
author: lorenz.henk@cybertec.at
tags: ["postgresql", "permissions", "privileges"] # max. 10 tags; lowercase; dash-separated
description: "PostgreSQL allows to set the default privileges" # max. 300 chars.
---

With PostgreSQL, the [`DEFAULT PRIVILEGES`](https://www.postgresql.org/docs/current/sql-alterdefaultprivileges.html) can be set as follows:

```
ALTER DEFAULT PRIVILEGES IN SCHEMA public
	GRANT SELECT ON TABLES TO PUBLIC;
```

All tables in schema `public` created in the future will be selectable by everyone (`PUBLIC`).

This does only apply for tables created by the user, who ran `ALTER DEFAULT PRIVILEGES`.
