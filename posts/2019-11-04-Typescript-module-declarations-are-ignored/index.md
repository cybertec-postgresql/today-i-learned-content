---
date: 2019-11-04
title: Typescript module declarations are ignored
author: lorenz.henk@cybertec.at
tags: ["typescript", "ts-node", "module", "declare", ".d.ts"] # max. 10 tags; lowercase; dash-separated
description: "" # max. 300 chars.
---

You can write custom type definitions for a module in `.d.ts` files, for example:

```typescript
// some-name.d.ts

// my-module will have the type `any`
declare module "my-module";

// specify the exports
declare module "my-other-module" {
  export function foo(bar: number): string;
}
```

`.d.ts` files should be in the `src` directory.

With `tsc`, this file is included globally.

Starting with [version 7](https://github.com/TypeStrong/ts-node/releases/tag/v7.0.0) of `ts-node`, `.d.ts` files are **not** included automatically.

Injecting `TS_NODE_FILES=true` tells `ts-node` to include the files as well.

See [here](https://github.com/TypeStrong/ts-node#help-my-types-are-missing) for more information.
