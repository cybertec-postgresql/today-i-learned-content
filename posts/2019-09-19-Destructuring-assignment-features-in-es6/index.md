---
date: 2019-09-19
title: Destructuring assignment features in es6
author: svitlana.lytvynenko@cybertec.at
tags: ["javascript", "es6"] # max. 10 tags; lowercase; dash-separated
description: "Object and array destructuring assignment features in javascript" # max. 300 chars.
---

Today I learned about the helpful **ES6** "[destructuring](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment)" feature to unpack arrays and objects.  \
It is a convenient way to extract values into distinct variables.

It is possible to **object-destructure arrays**:

```typescript
const { 0: x, 2: y, 3: z } = ['a', 'b', 'c', 'd'];
console.log(x) // 'a'
console.log(z) // 'd'
```

This works because [array indices are properties as well](https://exploringjs.com/impatient-js/ch_arrays.html#array-indices)!

Alternatively, [array-destructuring](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment#Array_destructuring) can be applied to any value that is iterable, not just to arrays:

```typescript
// Sets are iterable
const mySet = new Set().add('a').add('b').add('c');
const [first, second] = mySet;
console.log(first) // 'a'
console.log(second) // 'b'

// Strings are iterable
const [a, b] = 'xyz';
console.log(a) // 'x'
console.log(b) // 'y'
```
