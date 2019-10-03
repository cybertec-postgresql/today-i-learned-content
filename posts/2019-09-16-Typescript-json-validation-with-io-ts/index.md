---
date: 2019-09-16
title: Typescript json validation with io-ts
author: andres.garcia@cybertec.at
tags: ["typescript", "io-ts", "typing", "validation", "schema", "json"] # max. 10 tags; lowercase; dash-separated
description: "io-ts is a Typescript lib for defining types that can also perform runtime validations" # max. 300 chars.
---

There's a Typescript library called [io-ts](https://github.com/gcanti/io-ts) that can help to strong-type json
data fetched from the server and at the same time provide static typescript typing.

####Problem

Imagine we have this line that fetches some data from an endpoint:

```typescript
const employee = await fetchEmployee();
```

`employee` will probably have the `any` type. If we knew the shape of the employee object,
we could create a type and cast `employee`:

```typescript
type Employee {
  firstName: string;
  lastName: string;
}

const employee = await fetchEmployee() as Employee;
```

But now we are assuming the shape of `employee`, and if it changes in future versions of the backend, it can lead to
annoying runtime errors such as accessing properties on undefined objects, which can be hard to track. We could
validate it with a lib such as [ajv](https://github.com/epoberezkin/ajv), but we wouldn't be able to have a single
source of truth.

####Solution

With [io-ts](https://github.com/gcanti/io-ts) we can define a type like this:

```typescript
import * as t from 'io-ts';

// The runtime type we will use to validate the data fetched from the server
const Employee = t.type({
  firstName: t.string,
  lastName: t.string,
});

// The static type. The above runtime type acts as the single source of truth
type Employee = t.TypeOf<typeof Employee>;

// Now we can do this (in pseudo-code)
const employee = Employee.decode(await fetchEmployee());

console.log(employee.firstName);  // works
console.log(employee.foo);        // typescript compile error
```

Now `employee` is correctly typed, and the shape of the data is validated at runtime.

####Implementing the pseudo-code

The lib is great, but the documentation found in the repository's README is a little confusing. The easiest way I found
to just validate data and throw if the shape is incorrect is like this:

```typescript
import { getOrElse } from "fp-ts/lib/Either";  // io-ts has fp-ts as a peer dependency
import { failure } from "io-ts/lib/PathReporter";

const toError = (errors: any) => new Error(failure(errors).join('\n'));
const employee = getOrElse(toError)(Employee.decode(await fetchEmployee()));

if (employee instanceof Error) {
  throw employee;
}

console.log('the first name is', employee.firstName)
```

This steps can be easily extracted to a helper function.
