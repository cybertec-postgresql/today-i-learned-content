---
date: 2019-09-25
title: Configuring GitHub tab size
author: kieran.kaelin@cybertec.at
tags: ["github", "code", "tab", "indent", "editor", "editorconfig"] # max. 10 tags; lowercase; dash-separated
description: "See how to set the indent style and size for viewing GitHub code!" # max. 300 chars.
---

In order to configure the GitHub editor, simply create the file `.editorconfig` in your repository. \
This file makes use of the INI file format and as such may be configured like so:

```ini
[*.js]
indent_style = space
indent_size = 2
```

For more information on how to configure the file for the GitHub editor, please refer to the [EditorConfig wiki](https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties).
