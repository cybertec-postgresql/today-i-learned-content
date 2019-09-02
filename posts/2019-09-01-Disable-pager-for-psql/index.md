---
date: 2019-09-01
title: Disable pager for psql
author: lorenz.henk@cybertec.at
tags: ["postgresql", "psql", "pager", "automation"] # max. 10 tags; lowercase; dash-separated
description: "How to disable the pager in psql output" # max. 300 chars.
---

PostgreSQL's [CLI `psql`](https://www.postgresql.org/docs/current/app-psql.html) has lots of really helpful features.

For example, `psql` recognizes, when a large result-set is returned, and uses a [_pager_](https://unix.stackexchange.com/questions/144016/what-is-a-pager) to display the content.

This is great for viewing your data, but really annoying for automating tasks, as the pager needs user input to be terminated.
So, how can we circumvent / deactivate the pager?

```bash
# original, shows the pager
psql -h localhost -U postgres -c "SELECT * FROM pg_class"

# just pipe the output to `cat`
psql -h localhost -U postgres -c "SELECT * FROM pg_class" | cat

# if you are not interested in the output, you can also write to /dev/null
psql -h localhost -U postgres -c "SELECT * FROM pg_class" > /dev/null

# alternatively, you can use the environment variable `PAGER` to choose which pager should be used
PAGER=cat psql -h localhost -U postgres -c "SELECT * FROM pg_class"

# best method: completely turn off the pager
psql -h localhost -U postgres -P pager=off -c "SELECT * FROM pg_class"
```

Additionally, if you want to disable the pager while in interactive mode, just type `\pset pager off`.
