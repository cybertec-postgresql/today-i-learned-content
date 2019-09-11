---
date: 2019-9-11
title: Collapsible Markdown
author: kieran.kaelin@cybertec.at
tags: ["markdown"] # max. 10 tags; lowercase; dash-separated
description: "A short example on how to create collapsible Markdown" # max. 300 chars.
---

When presenting code or logs in Markdown, things tend to get out of hand quickly. \
The `<details>` and `<summary>` HTML tags can be used to mitigate this, which hide certain parts of your document. \
Be aware that Markdown specific syntax constructs within those HTML tags are only guaranteed to be rendered correctly by [CommonMark](https://spec.commonmark.org/0.29/#html-block) and / or [GFM](https://github.github.com/gfm/) compliant parsers (for example the GitHub Markdown parser).

```md
<details>
	<summary>Click to expand this section!</summary>
	<h5>A nice Javascript pitfall!</h5>

	```javascript
	console.log(['1', '7', '11'].map(parseInt));
	```
</details>
```

This Markdown snippet creates the following result:
<details>
  <summary>Click to expand this section!</summary>
  <h5>A nice Javascript pitfall!</h5>

  ```javascript
  console.log(['1', '7', '11'].map(parseInt));
  ```
</details>
