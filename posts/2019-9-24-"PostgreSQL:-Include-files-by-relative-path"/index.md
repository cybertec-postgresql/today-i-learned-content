---
date: 2019-9-24
title: "PostgreSQL: Include files by relative path"
author: kieran.kaelin@cybertec.at
tags: ["postgresql", "psql"] # max. 10 tags; lowercase; dash-separated
description: "Learn how to include other SQL files in PostgreSQL by using the relative file path." # max. 300 chars.
---

You can include files in **psql** using the relative path like so:

```sql
\ir <filename>
```

Or, as a longer alternative:

```sql
\include_relative <filename>
```

> **Note:**

<p style="margin-left: 20px">
	When using <code>\ir</code> from a file that was just included using <code>\ir</code>, the path will be interpreted relative to the nearest file in the include tree.
</p>
