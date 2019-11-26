---
date: 2019-11-26
title: Storybook with create-react-app and Typescript
author: lorenz.henk@cybertec.at
tags: [
    "storybook",
    "create-react-app",
    "init",
    "cli",
    "type",
    "typescript",
    "cra",
  ] # max. 10 tags; lowercase; dash-separated
description: "How to initialize Storybook with create-react-app and Typescript"
---

```bash
# generate a new app using create-react-app
yarn create react-app my-app --typescript
cd my-app

# install storybook cli
yarn add -D @storybook/cli

# initialize with storybook cli
yarn sb init
```

`yarn sb init` should **not** be called with the `--type react` flag.
Without `--type`, the cli figures out the correct type on its own.

The correct type for an app created with `create-react-app` is `react_scripts`.

Check out the [source code](https://github.com/storybookjs/storybook/blob/f2ed83b7fc6c41eb790001edb085f57bd327827f/lib/cli/lib/project_types.js#L3) for available types.
