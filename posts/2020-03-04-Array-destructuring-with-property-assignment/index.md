---
date: 2020-03-04
title: Array destructuring with property assignment
author: lorenz.henk@cybertec.at
tags: ["js", "javascript", "array", "destructuring", "variable"] # max. 10 tags; lowercase; dash-separated
description: "" # max. 300 chars.
---

Array destructuring is a nice feature to assign array values to variables.

The default usage is:

```js
const [first, second, third] = [1, 2];

// first:  1
// second: 2
// third:  3
```

But you can also use already existing variables.

```js
let first, second, third;

let values = [1, 2];

[first, second, third = 3] = values;

// first:  1
// second: 2
// third:  3
```

This also works for assigning object properties.

```js
let result = {};

[result.first, result.second, result.third = 3] = [1, 2];
// result: { first: 1, second: 2, third: 3 }
```
