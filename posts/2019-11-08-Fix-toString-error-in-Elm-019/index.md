---
date: 2019-11-08
title: Fix toString error in Elm 0.19
author: agustin.ramirez@cybertec.at
tags: ["tostring", "error", "elm", "fix"] # max. 10 tags; lowercase; dash-separated
description: "Fix toString error in Elm 0.19" # max. 300 chars.
---

Many initial tutorials of `Elm` show us how we can display an `Integer` as `String` using the util function called `toString`.

### Example

```Elm
module Main exposing (main)

import Html


add a b =
    a + b


result =
    add 1 2 |> add 3


main =
    Html.text (toString result)
```

But with the new version, precisely `v0.19` this shows an error.

![Cannot find a 'toString' variable](error-screenshot.png)

To solve this error, simply replace `toString` with `Debug.toString`.

```Elm
module Main exposing (main)

import Html


add a b =
    a + b


result =
    add 1 2 |> add 3


main =
    Html.text (Debug.toString result)
```

See [the upgrade instructions](https://github.com/elm/compiler/blob/master/docs/upgrade-instructions/0.19.0.md#functions-changed) for more information.
