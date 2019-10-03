---
date: 2019-09-15
title: Practical use of CSS Grid min-content
author: lorenz.henk@cybertec.at
tags: ["css", "grid", "min-content", "auto"] # max. 10 tags; lowercase; dash-separated
description: "How to use min-content to create a layout with fixed height" # max. 300 chars.
---

There are several use-cases for CSS Grid.
In this example, it is used to solve the following requirements:
- Create a table component with a **fixed height**
- A header should always be at the *top* of the component
- A footer should always be at the *bottom* of the component
- The component should *always have the same height*, no matter how many rows are displayed
- Overflow should be scollable

This can be accomplished with `auto` and `min-content`:

```html
<div class="grid">
  <div class="header-filter">
    ...
  </div>
  <div class="table">
    ...
  </div>
  <div class="footer-pagination">
    ...
  </div>
</div>
```

```html
.grid {
  display: grid;
  grid-template-rows: min-content auto min-content;
  height: 250px;
}

.table {
  overflow: auto;
}
```

Check out [this CodePen](https://codepen.io/lorenzhenk/pen/dybKKMO) for a working example.
