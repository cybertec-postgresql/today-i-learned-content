---
date: 2019-10-16
title: Get granted roles with psql
author: lorenz.henk@cybertec.at
tags: ["postgres", "psql", "role", "user", "permissions"] # max. 10 tags; lowercase; dash-separated
description: "A useful psql command to list granted roles." # max. 300 chars.
---

With `psql`, there is an easy way to check which roles are granted to a role: `\du`

```sql
henk=> CREATE ROLE accounting;
CREATE ROLE
henk=> CREATE ROLE alex;
CREATE ROLE
henk=> GRANT accounting TO alex;
GRANT ROLE
```

```
henk=> \du accounting
             List of roles
 Role name  |  Attributes  | Member of
------------+--------------+-----------
 accounting | Cannot login | {}

henk=> \du alex
              List of roles
 Role name |  Attributes  |  Member of
-----------+--------------+--------------
 alex      |              | {accounting}
```
