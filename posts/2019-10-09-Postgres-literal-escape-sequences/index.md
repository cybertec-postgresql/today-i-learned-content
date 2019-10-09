---
date: 2019-10-09
title: Postgres literal escape sequences
author: philip.trauner@cybertec.at
tags: ["postgresql", "e-string", "literal", "escape sequence"] # max. 10 tags; lowercase; dash-separated
description: Postgres escapes everything by default. This can occasionally lead to unexpected results. 
---

Postgres automatically escapes all occurrences of escape sequences if strings aren't prefixed with the `E` escape constant. This can lead to unexpected results:

```sql
select array_to_string(array['first line', 'second line', 'third line'], '\n');
```

```
           array_to_string
-------------------------------------
 first line\nsecond line\nthird line
```

Prefixing the separator string with the escape constant tells Postgres to interpret the sequence literally.

```sql
select array_to_string(array['first line', 'second line', 'third line'], E'\n');
```

```
 array_to_string
-----------------
 first line     +
 second line    +
 third reich
```

There's no need to prefix the template string when using `format`, as `E`-strings are substituted in literally.

```sql
select format('first line%ssecond line', E'\n');
```

```
   format
-------------
 first line +
 second line
```
