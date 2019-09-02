---
date: 2019-9-02
title: Postgres Constraint Naming Convention
author: philip.trauner@cybertec.at
tags: ["postgresql", "naming", "constraints"]
description: "Postgres constraints follow a bunch of implicit naming conventions. Let's make them explicit."
---

Sometimes it's necessary to manually specify a constraint name, which should then ideally follow some sort of naming convention or pattern.

Postgres already has an implicit naming convention in place, which goes like this:

```
{tablename}_{columnname(s)}_{suffix}
```

- `pkey` for **primary key** constraints

  - Single column

      ```sql
      create table foo (
          bar integer primary key
      );
      ```

      ```
                                    Table "public.foo"
         Column |  Type   | Collation | Nullable |             Default
        --------+---------+-----------+----------+---------------------------------
         bar    | integer |           | not null |
        Indexes:
            "foo_pkey" PRIMARY KEY, btree (bar)
      ```

  - Multiple columns

      ```sql
      create table foo (
          bar integer,
          baz integer,
          primary key (bar, bar)
      );
      ```

      ```
                        Table "public.foo"
         Column |  Type   | Collation | Nullable | Default
        --------+---------+-----------+----------+---------
         bar    | integer |           | not null |
         baz    | integer |           | not null |
        Indexes:
            "foo_pkey" PRIMARY KEY, btree (bar, baz)
      ```

- `key` for **unique** constraints

  - Single column

      ```sql
      create table foo (
          bar integer unique
      );
      ```

      ```
                    Table "public.foo"
         Column |  Type   | Collation | Nullable | Default
      --------+---------+-----------+----------+---------
         bar    | integer |           |          |
        Indexes:
          "foo_bar_key" UNIQUE CONSTRAINT, btree (bar)
      ```

  * Multiple columns

      ```
      create table foo (
          bar integer,
          baz integer,
          unique (bar, baz)
      );
      ```

      ```
                        Table "public.foo"
         Column |  Type   | Collation | Nullable | Default
        --------+---------+-----------+----------+---------
         bar    | integer |           |          |
         baz    | integer |           |          |
        Indexes:
            "foo_bar_baz_key" UNIQUE CONSTRAINT, btree (bar, baz)
      ```

- `excl` for **exclusion** constraints

  ```sql
  create table foo (
      bar text,
      baz text,
      exclude using gist (bar with =, baz with =)
  );
  ```

  ```
                 Table "public.foo"
     Column | Type | Collation | Nullable | Default
    --------+------+-----------+----------+---------
     bar    | text |           |          |
     baz    | text |           |          |
    Indexes:
        "foo_bar_baz_excl" EXCLUDE USING gist (bar WITH =, baz WITH =)
  ```

- `idx` for **indices**

  Indices can not be created without manually specifying a name.

- `fkey` for **foreign key** constraints

  - Single column

      ```sql
      create table foo (
          bar integer primary key
      );
      create table qux (
          bar integer references foo
      );
      ```

      ```
                        Table "public.qux"
         Column |  Type   | Collation | Nullable | Default
        --------+---------+-----------+----------+---------
         bar    | integer |           |          |
        Foreign-key constraints:
            "qux_bar_fkey" FOREIGN KEY (bar) REFERENCES foo(bar)
      ```

  - Multiple columns

      ```sql
      create table foo (
          bar integer,
          baz integer,
          primary key(bar, baz)
      );
      create table qux (
          bar integer,
          baz integer,
          foreign key(bar, baz) references foo (bar, baz)
      );
      ```

      ```
                        Table "public.qux"
         Column |  Type   | Collation | Nullable | Default
        --------+---------+-----------+----------+---------
         bar    | integer |           |          |
         baz    | integer |           |          |
        Foreign-key constraints:
            "qux_bar_fkey" FOREIGN KEY (bar, baz) REFERENCES foo(bar, baz)
      ```

- `check` for **check** constraints

  - Single column

      ```sql
      create table foo (
          bar integer check (id > 10)
      );
      ```

      ```
                        Table "public.foo"
         Column |  Type   | Collation | Nullable | Default
        --------+---------+-----------+----------+---------
         bar    | integer |           |          |
        Check constraints:
            "foo_bar_check" CHECK (id > 10)
      ```

  - Multiple columns

      ```sql
      create table foo (
          bar integer,
          baz integer,
          check (bar = baz)
      );
      ```

      ```
                        Table "public.foo"
         Column |  Type   | Collation | Nullable | Default
        --------+---------+-----------+----------+---------
         bar    | integer |           |          |
         baz    | integer |           |          |
        Check constraints:
            "foo_check" CHECK (bar = baz)
      ```

- `seq` for **sequences**

  ```sql
  create table foo (
      id serial
  );
  ```

  ```
                                Table "public.foo"
   Column |  Type   | Collation | Nullable |             Default
    --------+---------+-----------+----------+---------------------------------
     id     | integer |           | not null | nextval('foo_id_seq'::regclass)
  ```

