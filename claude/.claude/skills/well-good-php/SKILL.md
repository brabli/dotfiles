---
description: Coding standards for writing clean, maintainable PHP in this codebase.
when_to_use: Use whenever you are about to create, edit, review, or read a .php file - entities, controllers, services, subscribers, voters, tests, or any other PHP. Invoke this BEFORE writing or changing PHP so the code follows the standards on the first pass rather than needing rework.
---

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

### MUST
- PHP code MUST follow the [PSR-12](https://www.php-fig.org/psr/psr-12/) standard.
- Strict types MUST be delared at the top of every PHP file.
- Classes MUST be declared final if doing so does not break functionality.
- Types MUST be as narrow as possible throughout the codebase.
- Conditionals with multiple or complex condition statements MUST have their statements broken down into individual, clearly names variables to.
- Built-in functions and constants MUST be prefixed with a backslash `\`.
- "Yoda-conditions" MUST be used.
```php
// Bad
if ($var === null) {...}

// Good
if (null === $var) {...}
```
- Return statements MUST be a single value or variable.
```php
// Bad
return $var->someMethod()->anotherMethod();

// Good
$val = $var->someMethod()->anotherMethod();

return $val;
```
- Doctrine query conditions MUST be built with the `QueryBuilder` expression API rather than raw DQL strings. This means assigning the builder to a variable first, so `expr()` is reachable.
```php
// Bad - raw DQL strings
$emails = $this->createQueryBuilder('e')
    ->where('e.direction = :direction')
    ->andWhere('e.emailThread IS NULL')
    ->setParameter('direction', $direction)
    ->getQuery()
    ->getResult()
;

// Good - expression builder
$qb = $this->createQueryBuilder('e');

$emails = $qb
    ->where($qb->expr()->eq('e.direction', ':direction'))
    ->andWhere($qb->expr()->isNull('e.emailThread'))
    ->setParameter('direction', $direction)
    ->getQuery()
    ->getResult()
;
```
- Method names MUST say literally what the method does, using the vocabulary the framework and the domain already use. A figurative or borrowed verb MUST NOT be used where a plain one exists, and a name MUST NOT reuse a term the framework has already defined for something else.
```php
// Bad - "stamp" is Symfony Messenger's word for an Envelope stamp, and this adds a MIME header
protected function stampDeliveryReference(Message $message, Email $email): void

// Good
protected function addDeliveryReferenceHeader(Message $message, Email $email): void
```

### MUST NOT
- Assignment MUST NOT be performed inside a conditional.
- PHP 8.4+ code MUST NOT wrap "new" instances in parenthesis.
```php
// Pre PHP 8.4
(new Object())->someMethod()

// Post PHP 8.4
new Object()->someMethod()
```
- Class, interface, and enum imports MUST NOT be aliased with `as`. Alias only when two imports in the same file, or an import and the class declared in that file, resolve to the same short name. Shortening a long name, or making a name read better, is not a collision.
```php
// Bad - aliased for brevity, collides with nothing
use App\Enum\ComplianceScheduleItemKind as Kind;
use Symfony\Component\Security\Core\Authorization\Voter\VoterInterface as Voter;

// Good - imported under its own name
use App\Enum\ComplianceScheduleItemKind;
use Symfony\Component\Security\Core\Authorization\Voter\VoterInterface;

// Good - the short name `Kernel` is taken by the class this file declares
use Symfony\Component\HttpKernel\Kernel as BaseKernel;

class Kernel extends BaseKernel {...}
```
Namespace imports keep the framework's conventional alias, e.g. `use Doctrine\ORM\Mapping as ORM;` and `use Symfony\Component\Validator\Constraints as Assert;`. Those alias a namespace, not a type.

This rule governs PHP you are writing or changing. Aliases already in the codebase MUST NOT be refactored to satisfy it - some are deliberate, e.g. `use App\Model\CannedResponse\Token as T;` in a lexer test that repeats the name hundreds of times.

### SHOULD
- Assert statements SHOULD be used to confirm invariants such as:
    - The expected type of a value.
    - An expected value is present.
- Variables SHOULD be treated as immutable. Exceptions may include:
    - Common patterns where mutability is required such as $i in for-loops.
    - Instances where treating a variable as immutable would result in significant performance penalties.
- PHP code SHOULD be self-documenting.
- PHP code SHOULD read like well-written prose.

### SHOULD NOT
- Flag variables SHOULD NOT be used.
```php
// Bad - Flag exists
$flag = false;

foreach ($entities as $entity) {
    // ...
    if ($something) {
        $flag = true;
    }
}

if ($flag) {
    // Logic
}


// Good - No flag

foreach ($entities as $entity) {
    // ...
    if ($something) {
        // Logic
    }
}

```
