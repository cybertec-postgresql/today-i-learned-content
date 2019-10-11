---
date: 2030-12-31 # Auto updates on publish.
title: "TypeORM custom column name for relation"
author: lorenz.henk@cybertec.at
tags: ["typeorm", "javascript", "relation", "column"] # max. 10 tags; lowercase; dash-separated
description: "By default, TypeORM puts an 'Id' at the end of a relation column. Here's how to stop this behavior" # max. 300 chars.
---

If you're defining a relation in `TypeORM` the column name is assumed to be `column_name + "Id"`.
To customize the column name, use the `JoinColumn` decorator:

```js
@ManyToOne(type => Video)
@JoinColumn({name: "video_id"}) //without this, the column name would be `video_idId`
video_id: Video;
```

See [this issue](https://github.com/typeorm/typeorm/issues/1108) and [the docs](https://github.com/typeorm/typeorm/blob/master/docs/relations.md#joincolumn-options) for more information.
