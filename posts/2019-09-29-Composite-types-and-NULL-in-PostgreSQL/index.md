---
date: 2019-09-29
title: Composite types and NULL in PostgreSQL
author: lorenz.henk@cybertec.at
tags: ["postgresql", "composite-types", "null", "is-null", "row"] # max. 10 tags; lowercase; dash-separated
description: "Here we'll talk about interesting behavior with composite types and NULL" # max. 300 chars.
---

#### Basics

```sql
-- a row including only nulls is null
$ SELECT ROW(NULL, NULL) IS NULL;
-> true

-- a row including no nulls is not null
$ SELECT ROW(10, 10) IS NOT NULL;
-> true
```

#### Unusual

```sql
-- this row is not NULL
$ SELECT ROW(10, NULL) IS NULL;
-> false

-- but it's also not NOT NULL
$ SELECT ROW(10, NULL) IS NOT NULL;
-> false

-- there is a difference between `NOT ROW(...) IS NULL` and `ROW(...) IS NOT NULL`
$ SELECT NOT ROW(10, NULL) IS NULL;
-> true
```

#### Wait, what?

```sql
-- as mentioned above, a row including only nulls is null
$ SELECT ROW(NULL) IS NULL;
-> true

-- this does not apply recursively, though
$ SELECT ROW(ROW(NULL)) IS NULL;
-> false
```

##### What's going on there?

Values inside of a composite type are checked for `NULL` value equality,
which is *not* the same as recursively checking with `IS NULL`!

This behavior is explained in [this twitter post](https://twitter.com/PavloGolub/status/1177511637902753795).

We can (ab)use this to check if a value is literally `NULL` or just a value that `IS NULL`:

```sql
SELECT  value              AS value,
        value      IS NULL AS is_null,
        ROW(value) IS NULL AS is_null_value
FROM    (VALUES (NULL), (ROW(NULL))) AS x(value);
```

```
 value  | is_null | is_null_value
--------+---------+---------------
 <null> | t       | t
 ()     | t       | f
```

Check out [this blog post](https://www.cybertec-postgresql.com/en/a-postgresql-story-about-null-is-null-null-and-not-null/) for more information on `NULL` behavior.
