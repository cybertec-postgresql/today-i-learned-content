---
date: 2019-9-17
title: Pretty CSS Hack to debug layouts
author: agustin.ramirez@cybertec.at
tags: ["css", "hack", "debug", "layout"] # max. 10 tags; lowercase; dash-separated
description: "Bookmark to temporarily visualize the layout of a website" # max. 300 chars.
---

1. Create a new bookmark
2. Add the following code to the bookmark URL:

```javascript
    javascript: (function() {
	var elements = document.body.getElementsByTagName('*');
	var items = [];
	for (var i = 0; i < elements.length; i++) {
		if (elements[i].innerHTML.indexOf('* { background:#000!important;color:#0f0!important;outline:solid #f00 1px!important; background-color: rgba(255,0,0,.2) !important; }') != -1) {
			items.push(elements[i]);
		}
	}
	if (items.length > 0) {
		for (var i = 0; i < items.length; i++) {
			items[i].innerHTML = '';
		}
	} else {
		document.body.innerHTML +=
			'<style>* { background:#000!important;color:#0f0!important;outline:solid #f00 1px!important; background-color: rgba(255,0,0,.2) !important; }\
            * * { background-color: rgba(0,255,0,.2) !important; }\
            * * * { background-color: rgba(0,0,255,.2) !important; }\
            * * * * { background-color: rgba(255,0,255,.2) !important; }\
            * * * * * { background-color: rgba(0,255,255,.2) !important; }\
            * * * * * * { background-color: rgba(255,255,0,.2) !important; }\
            * * * * * * * { background-color: rgba(255,0,0,.2) !important; }\
            * * * * * * * * { background-color: rgba(0,255,0,.2) !important; }\
            * * * * * * * * * { background-color: rgba(0,0,255,.2) !important; }</style>';
	}
})();
```

To use it, just navigate to a website and click on the bookmark you defined.

The image below shows [this website](https://www.cybertec-postgresql.com/en/) with the bookmark activated.

![Screenshot of Cybertec Layout](./screenshot.png)

You can use it on any page.

Ain't that cool? 😀

P.S.: Tested on Chrome and Firefox.

Check the [official post](https://dev.to/gajus/my-favorite-css-hack-32g3) and this [Gist](https://gist.github.com/vcastroi/e0d296171842e74ad7d4eef7daf15df6) for more information.
