---
date: 2019-09-05
title: Using dynamic variables in psql
author: kieran.kaelin@cybertec.at
tags: ["postgresql", "psql"] # max. 10 tags; lowercase; dash-separated
description: "When developing in PostgreSQL, one may run into the fringe situation of being unable to use PL/pgSQL. Since the \\set command of psql can't be set dynamically, you have to fall back to runtime parameters for using dynamic variables." # max. 300 chars.
---

When developing in PostgreSQL, you may run into the fringe situation of being unable to use **PL/pgSQL** and instead having to fallback to plain **psql** (as was my case when writing tests with [pgTap](https://github.com/theory/pgtap), since **PL/pgSQL** insists on using `PERFORM` over `SELECT` for `void`-returning functions).

Writing these tests in plain SQL quickly results in bloated code, since you have to reuse certain IDs over and over again, even when using [CTEs](https://www.postgresql.org/docs/current/queries-with.html).\
While **psql** supports variables in the form of `\set {name} {value}`, these can not be dynamically set (i.e. using the result of a query).

However, it is possible to abuse runtime parameters (`SET {name} TO {value}`) for this purpose by making use of **PL/pgSQL**s `EXECUTE`, as shown in the following example:

```sql
DO $$
BEGIN
	EXECUTE format('SET %I TO %L', 'var.my_test_variable', (SELECT 1));
END $$;
```

Then, once you have returned to your plain SQL block, you may use `SELECT current_setting('var.my_test_variable')` to retrieve the value.

If used often, you could even move the `EXECUTE` block into its own function, receiving both name and value of the runtime parameter, and thus further removing unnecessary boilerplate code.
