---
date: 2019-10-11
title: Object preventExtension vs seal vs freeze
author: agustin.ramirez@cybertec.at
tags: ["javascript", "object", "prevent-extensions", "seal", "freeze"] # max. 10 tags; lowercase; dash-separated
description: "Comparations between the new Javascript Object protection methods" # max. 300 chars.
---

ECMAScript 5 introduced new `Object` methods to Javascript. Among them `preventExtensions`, `seal`, `freeze` methods will be compared to each other.

## `preventExtensions`

An object called by this method can't have _any new properties_ being added.

#### Example

```javascript
let person = {
  name: "Agustin",
  age: 27,
};

Object.preventExtensions(person);
Object.isExtensible(person); // return false

person.surname = "Ramirez";
console.log(person.surname); // return undefined

person.name = "Maria";
console.log(person); // return { name: "Maria", age: 27 }

delete person.age;
console.log(person); // return { name: "Maria" }
```

## `seal`

An object called by this method can not have _any new properties_ being added or _current properties deleted_.

#### Example

```javascript
let person = {
  name: "Agustin",
  age: 27,
};

Object.seal(person);
Object.isSealed(person); // return true

// In strict mode this will throw a `TypeError`
person.foo = "something";
console.log(person.foo); // return undefined

person.name = "Maria";
console.log(person); // return { name: "Maria", age: 27 }

delete person.age;
console.log(person); // return { name: "Maria", age: 27 }

Object.defineProperty(person, "name", {
  get: () => "Juan",
}); // Throw TypeError

console.log(person); // return { name: "Maria", age: 27 }
```

## `freeze`

An object called by this method can not have _any further changes_ done to it.

#### Example

```javascript
let person = {
  name: "Agustin",
  age: 27,
};

Object.freeze(person);
Object.isFrozen(person); // return true

person.name = "Maria";
console.log(person); // return { name: "Agustin", age: 27 }
```

### shallow only

All of these methods only work on object properties _shallowly_, meaning that just work with the direct property references.

```javascript
let person = {
  name: "Agustin", // Prevented, Sealed and Frozen
  age: 27, // Prevented, Sealed and Frozen
  address: {
    // Un-prevented, un-sealed and un-frozen
    country: "Argentina", // Un-prevented, un-sealed and un-frozen
    city: "Corrientes", // Un-prevented, un-sealed and un-frozen
  },
};
```

## Feature matrix

| Feature                             | default | preventExtensions | seal | freeze |
| ----------------------------------- | :-----: | :---------------: | :--: | :----: |
| **add** new properties              |    ✓    |                   |      |        |
| **remove** existing properties      |    ✓    |         ✓         |      |        |
| **change** existing property values |    ✓    |         ✓         |  ✓   |        |
