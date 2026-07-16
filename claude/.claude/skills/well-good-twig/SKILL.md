---
description: Coding standards for writing clean, lightweight, consistent Twig templates and components.
when_to_use: Use whenever you are about to create, edit, review, or read a .twig template or Twig component, or add Stimulus markup to Twig. Invoke this BEFORE writing or changing Twig so templates stay lightweight and follow the coding standards on the first pass.
---

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

## Instructions
- Twig code MUST follow the [coding standards](https://twig.symfony.com/doc/3.x/coding_standards.html#coding-standards).
- Twig files MUST aim to be as lightweight as possible.
- Stimulus helper functions MUST be used when adding Stimulus JS markup.
- Complex logic MUST be offloaded to PHP instead of being run inside the Twig template. Examples of where to add complex logic inclue:
    - Custom Twig filters
    - Custom Twig functions
    - Services
    - DTO/Models
- Semantic markup MUST be used.
- Twig Components SHOULD be used over "partial templates".
- Complex arguments to Twig files SHOULD be grouped into model objects, if the context makes sense.
- Layouts SHOULD prefer CSS flexbox with gaps or CSS grid with gaps over margins
- Methods MUST use short syntax.
```twig
{# Bad #}
{{ my_obj.getUsers() }}

{# Good #}
{{ my_obj.users }}
```
