---
date: 2019-10-21
title: GatsbyJS date formatting
author: lorenz.henk@cybertec.at
tags: ["gatsby", "graphql", "date", "format-string"] # max. 10 tags; lowercase; dash-separated
description: "" # max. 300 chars.
---

GatsbyJS allows you to set a format for a field of type date.
See the [source code](https://github.com/cybertec-postgresql/today-i-learned/blob/5ed2a693af2e9a3f9e0577c5ca7e683eda38552d/gatsby-node.js#L24) of this website.

```graphql
node {
  frontmatter {
    date(formatString: "YYYY-MM-DD")
  }
}
```

Under the hood, GatsbyJS uses [`moment.js`](https://momentjs.com/).
