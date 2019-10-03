---
date: 2019-09-09
title: Infinite rows with CSS Grid
author: lorenz.henk@cybertec.at
tags: ["css", "grid", "grid-auto-rows"] # max. 10 tags; lowercase; dash-separated
description: "The grid-auto-rows can be used as an alternative to grid-template-rows" # max. 300 chars.
---

[CSS Grids](https://caniuse.com/#feat=css-grid) can be used to layout your website in columns and rows.
But did you know you don't have to specify the *amount of rows*?

You can define the height for each `row` with [`grid-auto-rows`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-auto-rows).

```css
#grid {
  background-color: #1a2b3c;
  display: grid;
  grid-template-columns: repeat(10, 1fr);
  grid-auto-rows: 50px;
}

#item1 {
  background-color: #6699ff;
  grid-column: 1 / 4; /* width: 3fr */
  grid-row: 1 / 5; /* height: 200px */
}

#item2 {
  background-color: #66ffff;
  grid-column: 2 / 7; /* width: 5fr */
  grid-row: 2 / 11; /* height: 450px */
}
```

Check it out [on codepen](https://codepen.io/lorenzhenk/pen/xxKXjqp).

You can also use [`grid-auto-columns`](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-auto-columns) for infinite columns.
