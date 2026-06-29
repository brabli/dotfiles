---
description: Provides guidelines and instructions on how to write clean, consistent Twig code.
when_to_use: Whenever a Twig file is created, modified or read. Whenever Stimulus markup is added to a Twig file.
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
