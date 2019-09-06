---
date: 2019-9-06
title: Set CSS Grid item width
author: lorenz.henk@cybertec.at
tags: ["css", "grid", "span", "grid-column", "grid-row"] # max. 10 tags; lowercase; dash-separated
description: "This is an example" # max. 300 chars.
---

In CSS Grid, you specify the size and position of elements with `grid-column` and `grid-row`.
Normally you specify the position with `{start-position} / {end-position}`.

But you can also specify the width with `span`:

```
#item {
  /* 3 columns wide, 2 rows high */
  grid-column: 1 / span 3;
  grid-row: 1 / span 2;
}
```

Check out this [codepen example](https://codepen.io/lorenzhenk/pen/oNvpvvP).
