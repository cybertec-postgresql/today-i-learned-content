---
date: 2020-01-28
title: Sleeping more conveniently in PostgreSQL
author: pavlo.golub@cybertec.at
tags: ["postgresql", "tips", "tricks", "SQL", "sleep"] # max. 10 tags; lowercase; dash-separated
description: "How to conveniently use sleep() functions inside PostgreSQL scripts" # max. 300 chars.
---
Postgres' sleep functions are not particularly useful, as they should only be utilized for demonstration purposes (like provoking locking situations and then trying to find out who blocked whom).
After years of using the `pg_sleep()` function, which takes seconds as its input argument, I one day discovered that there are more convenient functions that even accept human readable input!

```sql
SELECT now();
SELECT pg_sleep_for('5 minutes');
SELECT  /* then do something …. */
SELECT pg_sleep_until('tomorrow 03:00');
```

More [tips and tricks](https://www.cybertec-postgresql.com/en/tips-and-tricks-to-kick-start-postgres-year-2020/) from our very own [Kaarel Moppel](https://www.cybertec-postgresql.com/en/author/cybertec_kaarel/)! 
