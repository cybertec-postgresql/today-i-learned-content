---
date: 2019-07-30
title: Pretty Printing JSON
author: lorenz.henk@cybertec.at
tags: ["json", "command-line", "python", "postgresql", "javascript", "formatting"] # max. 10 tags; lowercase; dash-separated
description: "How to pretty print json in different programming languages and in the command line" # max. 300 chars.
---

JSON is everywhere, but reading nested JSON without proper formatting can be a nightmare.

### PostgreSQL

The [function `jsonb_pretty`](https://www.postgresql.org/docs/current/functions-json.html) allows you to pretty print `jsonb` data.

```sql
\pset format unaligned
SELECT jsonb_pretty('{"name": "Lorenz", "team": {"name": "Team #1", "color", "blue"}}'::jsonb);

{
    "name": "Lorenz",
    "team": {
        "name": "Team #1",
        "color": "blue"
    }
}
```

### Javascript

If you work with JSON data in Javascript, you surely know the [function `JSON.stringify`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify).
But did you know it can prettify your JSON as well?

```js
JSON.stringify({"name": "Lorenz", "games_won": 4, "games_lost": 1}, null, 4)
                                      // number of spaces for indentation ^

{
    "name": "Lorenz",
    "games_won": 4,
    "games_lost": 1
}
```

### Python

Python's [`json` module](https://docs.python.org/3.7/library/json.html) adds functions to work with JSON.

```python
>>> import json
>>> print(json.dumps({"players": [{"name": "Lorenz"}, {"name": "Philip"}]}, indent=4))

{
    "players": [
        {
            "name": "Lorenz"
        },
        {
            "name": "Philip"
        }
    ]
}
```

### Command line using Python

You can also directly run the tool exposed by the `json` module from the command line:

```bash
$ echo '{"name": "Lorenz", "has_eyes": true}' | python3 -m json.tool

{
    "name": "Lorenz",
    "has_eyes": true
}
```
