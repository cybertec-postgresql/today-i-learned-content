---
date: 2019-09-14
title: Disable preview mode in VS Code
author: lorenz.henk@cybertec.at
tags: ["vs-code", "preview", "settings"] # max. 10 tags; lowercase; dash-separated
description: "Have enough of double-clicking your file to keep it open in VS Code? Apply these settings" # max. 300 chars.
---

![Screenshot of file opened in normal and in preview-mode](./screenshot.png)

What is the difference between the left and the right file? The right one is opened in **preview mode**.

Opening another file won't result in a new tab. Instead, the preview tab is changed to the new file - meaning the file currently previewed is closed.

The preview mode is used e.g. when you click on a file in the explorer or open a file through the [Quick Open](https://code.visualstudio.com/docs/editor/editingevolved#_quick-file-navigation) feature (<kbd>Ctrl</kbd> + <kbd>p</kbd>).

The following settings will disable the preview mode:
```
"workbench.editor.enablePreview": false,
"workbench.editor.enablePreviewFromQuickOpen": false
```

For more information on the preview mode, check out the [official documentation](https://code.visualstudio.com/docs/getstarted/userinterface#_preview-mode).
