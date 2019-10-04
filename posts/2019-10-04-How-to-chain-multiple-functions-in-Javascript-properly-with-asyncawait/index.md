---
date: 2019-10-04
title: How to chain multiple functions in Javascript properly with async/await
author: svitlana.lytvynenko@cybertec.at
tags: ["javascript", "es8"] # max. 10 tags; lowercase; dash-separated
description: "How to chain multiple functions in Javascript properly with async/await" # max. 300 chars.
---

The code below chains multiple functions waits for everything to resolve, and then sends the result:

```typescript
// chain any number of async functions
const asyncChain = (...fns) => x => fns.reduce(async (res, fn) => fn(await res), x);

// async functions
const add = async x => x + 1;
const multiply = async x => x * 2;
const square = async x => x * x;

const getResult = asyncChain(add, multiply, square);

(async () => console.log(await getResult(4)))(); // 100
```
