---
date: 2019-10-07
title: CSS class grouping
author: lorenz.henk@cybertec.at
tags: ["css", "class"] # max. 10 tags; lowercase; dash-separated
description: "How to get a better overview of your classes" # max. 300 chars.
---

In HTML, any symbol or undefined class name is ignored.
Thus, you can use custom separators to group your classes.

```html
<div class="sm-8 lg-3 bg-black fg-green custom-class1" />
<div class="sm-8 lg-3 / bg-black fg-green / custom-class1" />
<div class="[ sm-8 lg-3 ] [ bg-black fg-green ] [ custom-class1 ]" />
```
