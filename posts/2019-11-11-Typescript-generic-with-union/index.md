---
date: 2019-11-11
title: Typescript generic with union
author: lorenz.henk@cybertec.at
tags: ["typescript", "union", "generics"] # max. 10 tags; lowercase; dash-separated
description: "Understanding TypeScripts generics used with union" # max. 300 chars.
---

<details style="margin-bottom: 16px">
<summary><span style="font-weight: bold">Click here to see the initial setup</span></summary>

```typescript
enum MessageTypes {
  Success,
  DuplicateEmail,
}

interface ContentMapping {
  [MessageTypes.Success]: {
    data: any;
  };
  [MessageTypes.DuplicateEmail]: {
    email: string;
  };
}

interface Message<Type extends MessageTypes> {
  type: Type;
  content: ContentMapping[Type];
}
```

</details>

We'll compare the following two types:

```typescript
type Option1 = Message<MessageTypes.DuplicateEmail | MessageTypes.Success>;

type Option2 =
  | Message<MessageTypes.DuplicateEmail>
  | Message<MessageTypes.Success>;
```

<details style="margin-bottom: 16px">
<summary><span style="font-weight: bold">Let's substitute <code>Message</code> and <code>ContentMapping</code></span></summary>

```typescript
type Option1 = {
  type: MessageTypes.DuplicateEmail | MessageTypes.Success;
  content:
    | {
        data: any;
      }
    | {
        email: string;
      };
};

type Option2 =
  | {
      type: MessageTypes.DuplicateEmail;
      content: {
        email: string;
      };
    }
  | {
      type: MessageTypes.Success;
      content: {
        data: any;
      };
    };
```

</details>

In `Option1`, `type` and `content` are not connected.
A malformed `Message` can be created:

```typescript
const message: Option1 = {
  type: MessageTypes.DuplicateEmail,
  content: {
    data: "This should not be allowed!",
  },
};
```

On the other hand, `Option2` throws an error:

```typescript
const message2: Option2 = {
  type: MessageTypes.DuplicateEmail,
  content: {
    data: "This *is* not allowed!",
  },
};

Property 'email' is missing in type '{ data: string; }' but required in type '{ email: string; }'.
```

Check out [this TypeScript playground](https://www.typescriptlang.org/play/index.html#code/KYOwrgtgBAssDO8CGBzYAVAngBwVA3gFBRQDKYAxhQvADTFQAiY2ANgJYVIAuwAohCTtWhAL6FC7ELwBOAMyTUoAYQD200NxhJs2KSgIMA2nESoMOBADpyVGgF0AXIZIkAJjyTOkITAG4GUQCSExpzLFx4K2Y2Th5+QWEnF1dgRNZneG4ZfWCocXFJDXlFYFgwtAAeCLLgAA9eEDd4crM0GvgAPhTuS2ca+hIKdUbuZzUNaW1dfSMa+zEJQl7cKAB5bG52dQBGKABeVuQq02OLSOiWDi5eASFWKAAfI-DLKNtqRE6A5ct1ze2IAATAcGM9TuZKhD2m9LrEbgl7p0wS8ThVztYPjRvhISIRhiAslAIOjnBstrsDj0+qiMVEYtd4ndhIMoATRs4iK4oB5uF4oAAidAAC3YLXgwtUYFYbigIFU3CgACMykhWKxVAB3YBuACEAtZonoQQkBKJJLawCBZIB6hBhy5UBWwGc0LpcMZt3SrPZmk5DHcnmcQtFLQAVGKw3KFVA1RrtXqDYFjX4gA) for a live demo.
