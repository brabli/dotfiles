---
description: Coding standards for writing clean, lightweight, consistent Twig templates and components.
when_to_use: Use whenever you are about to create, edit, review, or read a .twig template or Twig component, or add Stimulus markup to Twig. Invoke this BEFORE writing or changing Twig so templates stay lightweight and follow the coding standards on the first pass.
---

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119).

### MUST
- Twig code MUST follow the [coding standards](https://twig.symfony.com/doc/3.x/coding_standards.html#coding-standards).
- Twig files MUST aim to be as lightweight as possible.
- Stimulus helper functions (`stimulus_controller()`, `stimulus_target()`, `stimulus_action()`) MUST be used instead of writing raw `data-controller`/`data-target`/`data-action` attributes.
- Complex logic MUST be offloaded to PHP instead of being run inside the Twig template. Examples of where to add complex logic inclue:
    - Custom Twig filters
    - Custom Twig functions
    - Services
    - DTO/Models

    When extracting logic out of a template, pick the layer that fits:
    - Entity methods for derived properties (`user.fullName` instead of `{{ user.firstName ~ ' ' ~ user.lastName }}`).
    - Twig extensions/functions for presentation-layer formatting that doesn't belong on an entity.
    - Voters/security for authorization checks (`is_granted('EDIT', entity)` instead of `{% if user.role == 'admin' %}`).
    - Controller/service for data aggregation, filtering, or complex preparation before the template renders.
    - Twig Components for reusable UI patterns with their own logic encapsulated in a PHP class.
- Semantic markup MUST be used, and only as much HTML as required - the less the better. Do not add redundant attributes (e.g. `type="button"` on a `<button>` where no distinction is needed).
- `aria-label` and `aria-hidden` attributes MUST be used on relevant elements for accessibility.
- Nested HTML elements and Twig constructs (`block`, `if`, `for`, etc.) MUST use 4-space indentation, each on its own line.
- Delimiters MUST have consistent internal spacing: `{{ variable }}`, not `{{variable}}`.
- Methods MUST use short syntax.
```twig
{# Bad #}
{{ my_obj.getUsers() }}

{# Good #}
{{ my_obj.users }}
```

### MUST NOT
- `<style>` and `<script>` tags MUST NOT be used unless there is a very strong reason - use utility classes for styling and Stimulus controllers for JavaScript instead.

### SHOULD
- Twig Components SHOULD be used over "partial templates".
- Complex arguments to Twig files SHOULD be grouped into model objects (DTOs) rather than passed as arrays, if the context makes sense. If a component accumulates too many parameters, consider splitting it into multiple specialised components instead of growing the parameter list further.
- Shorthand object notation SHOULD be used where possible: `{ user }` instead of `{ user: user }`.
- Layouts SHOULD prefer CSS flexbox with gaps or CSS grid with gaps over margins
- The project's utility classes and semantic colour classes SHOULD be used over hard-coded values (e.g. inline styles or arbitrary colours). If no existing utility class fits, consider adding one rather than reaching for an inline style.
