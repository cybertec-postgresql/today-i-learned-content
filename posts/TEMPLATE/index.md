---
date: 2030-12-31 # Auto updates on publish.
title: Browser fetch with manual redirect does not work as expected
author: lorenz.henk@cybertec.at
tags: ["javascript", "fetch", "redirect", "manual"] # max. 10 tags; lowercase; dash-separated
description: Using fetch with redirects in manual mode is not as easy as you might think!
---

Browser `fetch` allows you to configure how redirects should be handled via the [`redirect` option](https://javascript.info/fetch-api#redirect).

It allows one of the following values:
- `"follow"` - automatically follow HTTP-redirects
- `"error"` - throw a `NetworkError` on HTTP-redirect
- `"manual"` - do not redirect automatically

The default is `"follow"`.

The thing about `"manual"` is that it does not give you the redirect location, meaning you know that it should redirect, but you don't know where to redirect.

This is a [known problem](https://github.com/whatwg/fetch/issues/763), but there's currently no solution for it.

There's [a Github issue](https://github.com/whatwg/fetch/issues/601) that describes the idea of a special header `Access-Control-Allow-Visible-Redirect`, which will tell the browser to expose the redirect location in `"manual"` mode.
