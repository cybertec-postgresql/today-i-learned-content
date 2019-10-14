---
date: 2019-10-14
title: "Do not delete existing tables with TypeORM"
author: lorenz.henk@cybertec.at
tags: ["typeorm", "nodejs", "javascript", "synchronize", "tables", "database"] # max. 10 tags; lowercase; dash-separated
description: "How to use the synchronize parameter" # max. 300 chars.
---

[TypeORM](https://typeorm.io) is an amazing ORM for NodeJS.

But for some reason, the starter template recreates your tables by default,
which often leads to data loss.
This is due to the `synchronize` option in `ormconfig.json`.

If needed, you can enable / disable this option per `Entity`:

```js
@Entity({synchronize: true})
export class Temporary {
  ...
}
```
