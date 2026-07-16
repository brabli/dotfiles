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
- Functions that derive data from DOM elements MUST accept that data as an argument (e.g. targets, values, or a plain value object built from them) rather than querying the DOM themselves. This keeps them pure and testable outside the class.
- Types MUST be declared above the stimulus controller.
- Functions MUST have a return type specified

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
- Methods MUST NOT use `querySelector`/`querySelectorAll` to read controller state; use Stimulus targets or values instead, so every element the controller depends on is declared up front.
```ts
// Bad
private getSelectedLimitedTo(): string {
    const checked = this.element.querySelector<HTMLInputElement>("input[data-limited-to]:checked");

    return checked?.dataset.limitedTo ?? "";
}

// Good
static targets = ["limitedToInput"];

declare readonly limitedToInputTargets: HTMLInputElement[];

getSelectedLimitedTo(): string {
    return getSelectedLimitedTo(this.limitedToInputTargets);
}

// ...declared outside the class as a pure function
function getSelectedLimitedTo(inputs: HTMLInputElement[]): string {
    return inputs.find((input) => input.checked)?.dataset.limitedTo ?? "";
}
```

### SHOULD
- Pure functions SHOULD be used.
- Functions and methods SHOULD have their names preceded with a verb for readability and clarity. For example:
    - `isMoving()` instead of `moving()` for boolean checks.
    - `getThing()` instead of `thing()` when getting an object.
    - `tryGetThing()` if getting the thing could fail.
    - `fetchThing()` if a resource needs to be fetched over the internet.
- Domain concepts SHOULD be given a named type alias instead of being passed around as a bare primitive (`string`, `number`, `boolean`), so signatures read as domain language rather than generic types.
```ts
// Bad
const isDisabledCategory = (selected: string) => (category: string): boolean => ...

// Good
type Category = string;

function isDisabledCategory(selected: Category | null) {
    return (category: Category): boolean => selected === null || selected !== category;
}
```
- Types SHOULD be as narrow as possible: when the full set of valid values is statically known, use a literal union instead of a wide primitive. This only applies when the values are genuinely fixed ahead of time (e.g. a mode flag, a fixed set of states) — do not fabricate a union for values that are actually open-ended or loaded dynamically (e.g. server-rendered categories); a named alias over the primitive (previous rule) is the right level of narrowing there.
```ts
// Bad
type Direction = string;

// Good
type Direction = "left" | "right";
```
- Regular `function` declarations/expressions SHOULD be used instead of arrow functions assigned to `const`. This does not apply to a function *returned* from a curried function (currying requires returning a closure, and a `function` expression there gains nothing over an arrow), nor to short callbacks passed inline to iterator methods (`.map()`, `.filter()`, `.find()`, etc.), where an arrow function remains idiomatic.
```ts
// Bad
const getCategory = (element: HTMLElement): Category => element.dataset.limitedTo ?? "";

// Good
function getCategory(element: HTMLElement): Category {
    return element.dataset.limitedTo ?? "";
}
```
- For-loops SHOULD be used instead of `.forEach()`, unless the iteration is already part of a chain of other iterator methods (`.map()`, `.filter()`, etc.), in which case keeping it in the chain is preferred over breaking it into a loop.
```ts
// Bad
this.categoryButtonTargets.forEach((button) => {
    button.disabled = disabledCategories.has(getCategory(button));
});

// Good
for (const button of this.categoryButtonTargets) {
    button.disabled = disabledCategories.has(getCategory(button));
}
```

### SHOULD NOT
- Anonymous classes SHOULD NOT be given a name unless one is required for functionality reasons.

