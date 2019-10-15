---
date: 2019-10-15
title: Understanding Javascript at a low level
author: agustin.ramirez@cybertec.at
tags: ["javascript", "low-level", "parser", "abstract-syntax-tree", "ast"] # max. 10 tags; lowercase; dash-separated
description: "How does Javascript work under the hood? Let's find out!" # max. 300 chars.
---

Did you ever ask yourself how Javascript works under the hood? 
It's important to understand how the language we're working with works on a lower level.

## Top level view of the Javascript engine

- Receive source code
- Parse the code and produce an Abstract Syntax Tree (AST)
- Interpret as byte code and execute it
- The profiler checks for optimisations at run-time
- The compiler creates optimized code and replaces it with the byte code

![Javascript Engine](./JSEngine.png)

## What does the parser do?

![Parser](./Parser.png)

A parser takes the source code and creates an AST.
First, the parser splits the source code into tokens. There are different kinds of tokens, e.g. `let` and `new` are *keywords*, while `+` is an *operator*.

The tokens are then used to build the AST.
If something unexpected is found, a `SyntaxError` is thrown.

> A [`SyntaxError`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SyntaxError) is thrown when the Javascript engine finds a piece of codes that don't belong to the language syntax.

### Example

Let's try out the parser (using [this](https://esprima.org/demo/parse.html) website).

```bash
> var answer = 6 * 7;
```

```javascript
[
    {
        "type": "Keyword",
        "value": "var"
    },
    {
        "type": "Identifier",
        "value": "answer"
    },
    {
        "type": "Punctuator",
        "value": "="
    },
    {
        "type": "Numeric",
        "value": "6"
    },
    {
        "type": "Punctuator",
        "value": "*"
    },
    {
        "type": "Numeric",
        "value": "7"
    },
    {
        "type": "Punctuator",
        "value": ";"
    }
]
```

## Abstract Syntax Tree (AST)

It's a graph (data structure) that represents a program.

It's used in:

- Javascript Engine
- Bundlers: Webpack, Rollup, Parcel
- Transpilers: Babel
- Linters: ESLint, Prettify
- Type Checkers: Typescript, Flow
- Syntax Highlighters

You can check the generated AST in the [AST Explorer](https://astexplorer.net/).

Below is an example on how to add an ESLint rule.

```javascript
export default function(context) {
  return {
    VariableDeclaration(node) {
    	// const variable type
     	if (node.kind === "const") {
        	const declaration = node.declarations[0];
          	
          	// make sure that the value it's a number
          	if (typeof declaration.init.value === "number") {
            	 if (declaration.id.name !== declaration.id.name.toUpperCase()) {
                   	context.report({
                      	node: declaration.id,
                      	message: "The constant name should be in uppercase",
                      	fix: function(fixer) {
                         	return fixer.replaceText(declaration.id, declaration.id.name.toUpperCase()) 
                        }
                    })
                 }
            }
        }
    }
  };
};
```

### Example using AST to extend an ESLint rule without fix option

![Example using AST to extend an ESLint rule without fix option](./AST-without-fix.png)

### Example using AST to extend an ESLint rule with fix option

![Example using AST to extend an ESLint rule with fix option](./AST-with-fix.png)
