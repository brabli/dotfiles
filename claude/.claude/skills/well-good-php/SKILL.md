---
description: Coding standards for writing clean, maintainable PHP in this codebase.
when_to_use: Use whenever you are about to create, edit, review, or read a .php file - entities, controllers, services, subscribers, voters, tests, or any other PHP. Invoke this BEFORE writing or changing PHP so the code follows the standards on the first pass rather than needing rework.
---

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## Instructions
- PHP code MUST follow the [PSR-12](https://www.php-fig.org/psr/psr-12/) standard.
- Strict types MUST be delared at the top of every PHP file.
- Classes MUST be declared final if doing so does not break functionality.
- Types MUST be as narrow as possible throughout the codebase.
- Assert statements SHOULD be used to confirm invariants such as:
    - The expected type of a value.
    - An expected value is present.
- Variables SHOULD be treated as immutable. Exceptions may include:
    - Common patterns where mutability is required such as $i in for-loops.
    - Instances where treating a variable as immutable would result in significant performance penalties.
- Assignment MUST NOT be performed inside a conditional.
- Conditionals with multiple or complex condition statements MUST have their statements broken down into individual, clearly names variables to.
- Built-in functions and constants MUST be prefixed with a backslash `\`.
- PHP code SHOULD be self-documenting.
- PHP code SHOULD read like well-written prose.
- "Yoda-conditions" MUST be used.
```php
// Bad
if ($var === null) {...}

// Good
if (null === $var) {...}
```
- PHP 8.4+ code MUST NOT wrap "new" instances in parenthesis.
```php
// Pre PHP 8.4
(new Object())->someMethod()

// Post PHP 8.4
new Object()->someMethod()
```
- Return statements MUST be a single value or variable.
```php
// Bad
return $var->someMethod()->anotherMethod();

// Good
$val = $var->someMethod()->anotherMethod();

return $val;
```
