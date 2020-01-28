---
date: 2030-12-31 # Auto updates on publish.
title: SELECT INTO STRICT
author: lorenz.henk@cybertec.at
tags: ["postgres", "plpgsql", "select", "variable", "into", "strict"] # max. 10 tags; lowercase; dash-separated
description: "How to use SELECT INTO in PostgreSQL PLPGSQL." # max. 300 chars.
---

PLPGSQL allows you to write a value from a select query into a variable, using
the `SELECT ... INTO variable` syntax. If no rows match, the variable is `NULL`.
If more than one row matches, the variable is set to the first row.

`STRICT` throws an error if no / too many rows were supplied.

```sql
BEGIN
    SELECT * INTO STRICT myrec FROM emp WHERE empname = myname;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE EXCEPTION 'employee % not found', myname;
        WHEN TOO_MANY_ROWS THEN
            RAISE EXCEPTION 'employee % not unique', myname;
END;

```

Check out [the documentation](https://www.postgresql.org/docs/current/plpgsql-statements.html#PLPGSQL-STATEMENTS-SQL-ONEROW)
for more information.
