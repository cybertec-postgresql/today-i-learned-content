---
date: 2019-11-07
title: How to turn off test caching for golang!
author: pavlo.golub@cybertec.at
tags: ["golang", "test", "pg_timetable"] # max. 10 tags; lowercase; dash-separated
description: "Testing Golang projects you sometimes can see that test results are cached, meaning they are not executed since no source files changes were applied. However, your test cases might depend on environment they are running on, just like our `pg_timetable` scheduler depends on `PostgreSQL` database" # max. 300 chars.
---
When testing Golang projects you'll notice that test results are cached for as long as their corresponding source files remain unchanged. This is generally advantageous, unless your test cases behave differently depending on the environment that they are running in, just like our 
[pg_timetable](https://github.com/cybertec-postgresql/pg_timetable) scheduler depends on a `PostgreSQL` database.

Before `Go 1.12` the known solution was to use the `GOCACHE=off` environment variable, e.g.

```
$ GOCACHE=off go test ./internal/pgengine -v
```

However [starting](https://tip.golang.org/doc/go1.12#gocache) from `Go 1.12` this leads to the error:
```
$ GOCACHE=off go test ./internal/pgengine -v
build cache is disabled by GOCACHE=off, but required as of Go 1.12
```

As a solution one may clear the build cache explicitly before running tests:

```
$ go clean -cache
```

Or only clean the test cache:

```
$ go clean -testcache
```

Another approach is to use [environmental variables](https://tip.golang.org/cmd/go/#hdr-Environment_variables):

```
$ GOFLAGS="-count=1" go test ./internal/pgengine -v
```
