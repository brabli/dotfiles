---
description: Provides guidelines and instructions on how to write clean, consistent Stimulus JS code.
when_to_use: Whenever a JavaScript or TypeScript Stimulus class file is modified
---

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## Instructions
- Anonymous classes SHOULD NOT be given a name unless one is required for functionality reasons.
- Pure functions SHOULD be used.
- Functions with more than one argument MUST be curried.
- Functions that are not lifecycle methods, actions or that depend on class state MUST be declared outside of the class.
- Classes MUST have the minimum number of targets possible.
- Functions and methods SHOULD have their names preceded with a verb for readability and clarity. For example:
    - `isMoving()` instead of `moving()` for boolean checks.
    - `getThing()` instead of `thing()` when getting an object.
    - `tryGetThing()` if getting the thing could fail.
    - `fetchThing()` if a resource needs to be fetched over the internet.

