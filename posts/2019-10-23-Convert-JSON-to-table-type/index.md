---
date: 2019-10-23
title: "Convert JSON to table type"
author: lorenz.henk@cybertec.at
tags: ["postgres", "json", "table", "type"] # max. 10 tags; lowercase; dash-separated
description: "The PostgreSQL function json_populate_record can be used to cast a JSON object to a table type" # max. 300 chars.
---

The function [`json_populate_record`](https://www.postgresql.org/docs/10/functions-json.html) can be used to cast a JSON object to a table type:

```sql
CREATE TABLE foo(bar int);

SELECT  *
FROM    json_populate_record(NULL::foo, '{"bar": 42}')
```

```
+-------+
| bar   |
|-------|
| 42    |
+-------+
```

This can also be used to insert into the table:

```sql
INSERT INTO foo
SELECT *
FROM   json_populate_record(NULL::foo, '{"bar": 42}')
```
