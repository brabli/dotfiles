---
description: Coding standards for writing clean, consistent Stimulus controllers.
when_to_use: Use whenever you are about to create or edit a Stimulus controller (e.g. assets/controllers/*_controller.ts or *_controller.js), or build a new JS/TS feature in a Stimulus app. Invoke this BEFORE writing the controller so it follows the standards on the first pass.
---

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

### MUST
- Functions MUST be declared after the Stimulus controller.
- Functions with more than one argument MUST be curried.
- Functions that are not lifecycle methods, actions or that depend on class state MUST be declared outside of the class.
- Classes MUST have as few stimulus targets possible.

### MUST NOT
- Conditionals MUST NOT use shorthand blocks.
```ts
// Bad
if (someCondition) return true;

// Good
if (someCondition) {
    return true;
}
```

### SHOULD
- Pure functions SHOULD be used.
- Functions and methods SHOULD have their names preceded with a verb for readability and clarity. For example:
    - `isMoving()` instead of `moving()` for boolean checks.
    - `getThing()` instead of `thing()` when getting an object.
    - `tryGetThing()` if getting the thing could fail.
    - `fetchThing()` if a resource needs to be fetched over the internet.

### SHOULD NOT
- Anonymous classes SHOULD NOT be given a name unless one is required for functionality reasons.
