---
date: 2030-12-31 # Auto updates on publish.
title: Send notifications with Python
author: lorenz.henk@cybertec.at
tags: ["python", "notification"] # max. 10 tags; lowercase; dash-separated
description: "Check out this cool open-source project for sending notifications through several different providers" # max. 300 chars.
---

Some time ago, my family planned a vacation - we wanted to go by train.
At the time of planning, the tickets for the train could not yet be purchased.
We wanted to know as soon as the tickets are available for purchase, because the cheaper early-bird tickets would be sold out very quickly.

I built a program to fetch the website every few hours and check if the tickets are available for purchase.

I needed to notify myself in some way. For that task, I found [this](https://github.com/notifiers/notifiers) great open-source python module. Check out the [list of supported providers](https://github.com/notifiers/notifiers#supported-providers).

The program sent me a Pushbullet message as soon as the tickets were available and we got the early-bird ones.
