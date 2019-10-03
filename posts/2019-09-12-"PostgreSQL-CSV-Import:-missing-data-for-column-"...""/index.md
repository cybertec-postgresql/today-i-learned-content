---
date: 2019-09-12
title: "PostgreSQL CSV Import: missing data for column \"...\""
author: philip.trauner@cybertec.at
tags: ["postgresql", "csv", "psql", "error"] # max. 10 tags; lowercase; dash-separated
description: Failing CSV import? Add a newline! (no, seriously)
---

## Problem
The following `.sql` script will error out prematurely:
```sql
create table if not exists foo (
	bar text not null,
	baz text not null
);

copy foo (bar, baz) from stdin (format csv, delimiter ';', header true);
bar;baz
Lorem;ipsum
dolor;sit
amet,;consectetur
\.
```

Here's the accompanying `psql` output:
```
CREATE TABLE
psql:<stdin>:11: ERROR:  missing data for column "baz"
CONTEXT:  COPY foo, line 5: "\."
```

## Solution
Adding a newline after the `\.` termination sequence fixes the error.
