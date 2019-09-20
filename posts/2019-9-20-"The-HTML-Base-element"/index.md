---
date: 2019-9-20
title: "The HTML Base element"
author: svitlana.lytvynenko@cybertec.at
tags: ["html", "base", "document", "metadata", "reference"] # max. 10 tags; lowercase; dash-separated
description: "The HTML base element specifies the base URL to use for all relative URLs contained within a document." # max. 300 chars.
---

The **HTML `<base>` element** specifies attributes for all links in the document at once. \
Let's take a look at this example:

```html
<head>
  <base target="_blank">
</head>
```
Now **all** links will open in a new tab by default.

Additionally, the `href` attribute can be set within `<base>` tag. This sets the base URL to be used throughout the document for relative URL addresses.

For example:
```html
<head>
  <base href="https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base">
</head>
```

The following link:
```html
<body>
  ...
  <a target="_blank" href="#Usage_notes">Usage notes</a>
  ...
</body>
```
Will actually point to
```html
https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base#Usage_notes
```

> **Note:**
  - `<base>` shouldn't have a closing tag. 🤷
  - There can be only one base element in a document.

[More info ℹ️](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base)
