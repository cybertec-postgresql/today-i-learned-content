---
date: 2019-11-06
title: docker-compose for postgres with db init script
author: agustin.ramirez@cybertec.at
tags: ["docker-compose", "postgres", "docker", "db-init-script"] # max. 10 tags; lowercase; dash-separated
description: "docker-compose for postgres with db init script(s)" # max. 300 chars.
---

### Single script

```yml
postgres:
  image: postgres
  volumes:
    - ./init.sql:/docker-entrypoint-initdb.d/init.sql
```

### Multiple scripts

Multiple scripts run in alphabetical order,
thus it's good practice to prefix them with a number.

```yml
volumes:
  - ./schema.sql:/docker-entrypoint-initdb.d/1-schema.sql
  - ./data.sql:/docker-entrypoint-initdb.d/2-data.sql
```

### Directory containing scripts

```yml
volumes:
  - ./init-scripts:/docker-entrypoint-initdb.d
```
