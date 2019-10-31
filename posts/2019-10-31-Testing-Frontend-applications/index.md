---
date: 2019-10-31
title: Testing Frontend applications
author: agustin.ramirez@cybertec.at
tags: ["testing", "testing-libraries", "jest", "cypress"] # max. 10 tags; lowercase; dash-separated
description: "Different libraries and approaches to test frontend applications" # max. 300 chars.
---

We know that testing is hard. Imagine testing a frontend applications 🤯.

So for that, we are going to cover different approaches and review several libraries to test a frontend application.

## Static Testing

Use [ESLint](https://eslint.org/) to detect bugs, e.g. typos, and codebase improvements on build time.
Use [Typescript](https://www.typescriptlang.org/) to detect type bugs on build time.

```bash
    uploader.tsx
        44:2    error     Expected '===' and instead saw '=='    eqeqeq
```

```bash
    greeter.ts(8,21): error TS2345: Argument of type ‘number[]’ is not assignable to parameter of type ‘string’.
```

## Logic Unit Testing

Use [Jest](https://jestjs.io/) to unit test business logic decoupled from UI.

```javascript
import React from "react";
import renderer from "react-test-renderer";
import App, { Counter, reducer } from "./App";

const list = ["a", "b", "c"];

describe("App", () => {
  describe("Reducer", () => {
    it("should set a list", () => {
      const state = { list: [], error: null };
      const newState = reducer(state, {
        type: "SET_LIST",
        list,
      });
      expect(newState).toEqual({ list, error: null });
    });
  });
  ...
});
```

## Component Unit Testing

Use [Jest](https://jestjs.io/) to unit tests the component using different possible approaches.

### Regression Testing with Snapshots

Use [Jest Snapshots](https://jestjs.io/docs/en/snapshot-testing#snapshot-testing-with-jest) for regression testing of the output.

```javascript
import React from "react";
import { render } from "@testing-library/react";
import LoginForm from "./LoginForm";

test("LoginForm should generate the correct HTML and CSS", () => {
  const onSubmit = jest.fn();

  const { asFragment } = render(<LoginForm onSubmit={onSubmit} />);
  expect(asFragment()).toMatchSnapshot();
});
```

> Use [Storybook](https://storybook.js.org/) with [Storyshoots](https://github.com/storybookjs/storybook/tree/master/addons/storyshots) or [Jest Image Snapshot](https://github.com/americanexpress/jest-image-snapshot) for visual regression testing.

### Behavior Testing with Testing Library

Use [Testing Library](https://testing-library.com/) to test the behavior of the components from the user point of view.

```javascript
import React from "react";
import { render, fireEvent } from "@testing-library/react";
import LoginForm from "./LoginForm";

test("LoginForm should call the onSubmit callback", () => {
  const onSubmit = jest.fn();

  const { getByText } = render(<LoginForm onSubmit={onSubmit} />);
  fireEvent.click(getByText(/send/));
  expect(onSubmit).toHaveBeenCalled();
});
```

### Integration Test for Complex Component

Use [Cypress](https://www.cypress.io/) or [TestCafe](https://devexpress.github.io/testcafe/) to test complex workflows as a real user, in a real browser with a fake backend and faking any HTTP call.

```javascript
import { RequestMock } from "testcafe";
import { within, addTestCafeTestingLibrary } from "@testing-library/testcafe";

const loginAPIMock = RequestMock.onRequestTo(
  "http://localhost:3000/api",
).respond(null, 200);

fixture`Login`.beforeEach(addTestCafeTestingLibrary)
  .page`http://localhost:3000`.requestHooks(loginAPIMock);

test("fill login", async t => {
  const { getByLabelText, getByText } = await within("body");

  await t.typeText(getByLabelText(/email/), "test@test.com");
  await t.typeText(getByLabelText(/password/), "abc123");
  await t.click(getByText(/submit/));
  await t.expect(getByText(/success/).exists).ok();
});
```

## End to End Tests for Complex Workflows

Use [Cypress](https://www.cypress.io/) or [TestCafe](https://devexpress.github.io/testcafe/) to test complex workflows as a real user, in a real browser with a real working backend.

```javascript
import { within, addTestCafeTestingLibrary } from "@testing-library/testcafe";

fixture`Login`.beforeEach(addTestCafeTestingLibrary)
  .page`http://localhost:3000`;

test("fill login", async t => {
  const { getByLabelText, getByText } = await within("body");

  await t.typeText(getByLabelText(/email/), "test@test.com");
  await t.typeText(getByLabelText(/password/), "abc123");
  await t.click(getByText(/submit/));
  await t.expect(getByText(/success/).exists).ok();
});
```

Using tests, we don't have to be scared about deploying on Friday anymore 🥳.
