---
date: 2019-9-30
title: Enhance Redux props with ReturnType
author: lorenz.henk@cybertec.at
tags: ["react", "redux", "typescript", "typing", "returntype"] # max. 10 tags; lowercase; dash-separated
description: "Make use of mapStateToProps for typing your component props" # max. 300 chars.
---

The following example is built in [the offical Redux documentation](https://redux.js.org/recipes/usage-with-typescript):


```typescript
import { AppState } from './store'

import { SystemState } from './store/system/types'

import { ChatState } from './store/chat/types'

interface AppProps {
  chat: ChatState
  system: SystemState
}

const mapStateToProps = (state: AppState) => ({
  system: state.system,
  chat: state.chat
})
```

Here, `SystemState` and `ChatState` are imported and used manually.

But as `AppState` is correctly typed, we can use our [beloved `ReturnType`](/post/2019-08-31-Typescript-ReturnType/) instead:

```typescript
import { AppState } from './store'

type AppProps = ReturnType<typeof mapStateToProps>

const mapStateToProps = (state: AppState) => ({
  system: state.system,
  chat: state.chat
})
```

Check out [this CodeSandbox](https://codesandbox.io/s/redux-typescript-example-qwjq9) for a runnning example.
