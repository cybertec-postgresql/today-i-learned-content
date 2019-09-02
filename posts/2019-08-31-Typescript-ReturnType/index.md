---
date: 2019-08-31
title: Typescript ReturnType
author: lorenz.henk@cybertec.at
tags: ["typescript", "typing", "utility", "returntype"] # max. 10 tags; lowercase; dash-separated
description: "Showcase the ReturnType utility type from Typescript" # max. 300 chars.
---

Typescript includes several useful [utility types](https://www.typescriptlang.org/docs/handbook/utility-types.html) to enhance the type declarations of your code-base.

The `ReturnType` function is one of my favorite ones, as it helps reduce type definition duplication.

Suppose you have the following function definition:

```typescript
type IsInText = (
  text: string
) => (
  term: string,
  minCount: number,
  maxCount?: number,
  caseSensitive?: boolean
) => boolean
```

Now we want to write a function `allTermsInText`, that takes the function _returned by_ `isInText` as an argument. It should be used like:

```typescript
allTermsInText(["Typescript", "awesome"], isInText("Typescript is awesome!"))
```

Here is the definition **without** the utility type:

```typescript
type AllTermsInText = (
  terms: string[],
  search: (
    term: string,
    minCount: number,
    maxCount?: number,
    caseSensitive?: boolean
  ) => boolean
) => boolean
```

And here the same function definition, but using **`ReturnType`** for the parameters:

```typescript
let AllTermsInText = (terms: string[], search: ReturnType<IsInText>) => {
  return !terms.find(term => !search(term, 1))
}
```
