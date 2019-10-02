---
date: 2019-10-02
title: Typescript function parameter type
author: lorenz.henk@cybertec.at
tags: ["typescript", "typing", "function", "parameters", "utility"] # max. 10 tags; lowercase; dash-separated
description: "Did you know there is a utility type to retrieve function parameters?" # max. 300 chars.
---

[A previous post](https://til.cybertec-postgresql.com/post/2019-08-31-Typescript-ReturnType/) mentioned the [Typescript `ReturnType` utility type](https://www.typescriptlang.org/docs/handbook/utility-types.html). It is really handy to retrieve the return type of a function.

But there is also a type to retrieve the parameter list of a function. Meet `Parameters<T>`.

```typescript
const add = (first: number, second: number) => first + second;

const cache = <T extends (...args: any) => any>(func: T) => {
  const cacheObject = {};
  return (...args: Parameters<T>) => {
    const hashedArgs = JSON.stringify(args);
    if (cacheObject.hasOwnProperty(hashedArgs)) {
      return cacheObject[hashedArgs];
    } else {
      return (cacheObject[hashedArgs] = func(...args));
    }
  };
};
```

See the [full example here](https://codesandbox.io/s/dreamy-butterfly-3fqgh).


The code can be found at [`lib/lib.es5.d.ts`](https://github.com/microsoft/TypeScript/blob/master/lib/lib.es5.d.ts#L1479):

```typescript
/**
 * Obtain the parameters of a function type in a tuple
 */
type Parameters<T extends (...args: any) => any> = T extends (...args: infer P) => any ? P : never;
```
