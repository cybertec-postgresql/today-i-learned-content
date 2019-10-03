---
date: 2019-09-13
title: Different color in Firefox and Chromium
author: lorenz.henk@cybertec.at
tags: ["color", "chrome", "chromium", "force-color-profile"] # max. 10 tags; lowercase; dash-separated
description: "Do Chrome and Firefox display the same color in a different way?" # max. 300 chars.
---

Today I opened a website in Firefox and Chromium simultaneously.
I noticed that the same color looks different in the two browsers.

I used the following inline website to check it out:
```html
data:text/html,
<style>
  body {
    margin: 0;
    padding: 0;
  }

  div {
    width: 100vw;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: blue;
    color: white;
    font-size: 20vw;
  }
</style>
<body><div>0000ff</div></body>
```

![Difference between Firefox and Chromium color](./diff.png)

Turns out that this is due to the color profile selected by the browser.

You can change the color profile of Chrome / Chromium at [chrome://flags/#force-color-profile](chrome://flags/#force-color-profile).

![Force Color Profile option](./solution.png)

Check [here](https://stackoverflow.com/questions/48129374/chromium-and-firefox-display-colors-differently-and-i-dont-know-which-one-is-do) for more information.
