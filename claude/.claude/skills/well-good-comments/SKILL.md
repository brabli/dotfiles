---
name: well-good-comments
description: Standards for writing minimal, load-bearing code comments in this codebase.
when_to_use: Use whenever you are about to write, add, or review a code comment in any language - PHP docblocks, Twig {# #}, Stimulus/TypeScript, shell, config. Also when asked to "document," "explain," or make code readable for someone unfamiliar with it. Invoke this BEFORE writing comments so they follow the standards on the first pass, and again before finishing a coding task.
---

# Well Good Comments

The default is **no comment**. Names, types and the code itself carry the meaning; a comment is an admission that something could not be carried that way.

"Does it explain why?" is not a usable bar — any comment can be dressed up as a why. Use the checks below instead. Being asked to "document" sets intent (help the reader), not a quota.

## The checks, in order

Run every one of them on every comment, including docblocks and Twig `{# #}`.

**1. The bar — name the justification.** A comment must record a fact that appears **nowhere in the code being read**, and must fit one of exactly these:

1. **External constraint** — a limit, quirk or requirement from outside the codebase (third-party API, spec, protocol), including the arithmetic behind a magic number.
2. **Road not taken** — the obvious approach is wrong here for a concrete reason, and someone would otherwise "simplify" it back.
3. **Silent failure** — a precondition, ordering or invariant that breaks quietly rather than loudly when violated.
4. **Surprising safety** — why something that looks unsafe or missing (a removed check, a swallowed error) is in fact fine.

If you cannot name the number, in a few words, without hedging — delete it. "Gives helpful context", "explains the intent", "says what this is for" are not on the list.

```php
// 1 — an external limit, plus where the number came from
/**
 * Postmark refuses a message over 10MB in total, and MIME base64-encodes attachments into that
 * budget at roughly a third again their size. 7MB of files leaves room for the body and headers.
 */
private const int MAX_TOTAL_ATTACHMENT_BYTES = 7 * 1024 * 1024;

// 2 — the obvious em->flush() is a real past bug
/**
 * Writes the delivery columns straight to the row, without loading it. A delivery result arrives
 * in the messenger worker: there is no user behind it, and flushing there would commit whatever
 * else happens to be pending.
 */

// 4 — one line, explains why the missing check is safe
// The entity allows blank content for inbound email, so a reply is constrained here.
```

Real comments that fail the bar, however well written:
- `/** Clears any earlier failure so a resend does not keep showing the last error. */` on a method whose body visibly nulls those fields.
- `/** ...with attachments joined in so rendering it costs one query. */` on `leftJoin` + `addSelect`. A working developer on this stack knows the idiom.
- `/** Both set together when a send fails, so staff can see why before resending. */` on two adjacent nullable fields.

All four describe the code **as it is**. A comment about a case that does not exist yet fits none of them, however useful it feels:

```yaml
# Bad — the second sentence documents a component nobody has written
# Live components render whatever the page they sit on renders, and carry no #[IsGranted]
# of their own. No maintenance-area component is live; one would need its own rule here.
- { path: ^/_components, roles: ROLE_CUSTOMER }

# Good — the one fact that is true today and would be lost if the line were deleted
# Live components carry no #[IsGranted], so this line is their only access check.
- { path: ^/_components, roles: ROLE_CUSTOMER }
```

**2. The rename-test.** If the comment defines what an identifier *is*, a better name removes it. Length and a formal docblock don't turn a definition into documentation.

```php
/** The chance, as a percentage, that a given helpdesk job has been emailed out. */
private const int CHANCE_OF_THREADS = 50;          // bad: comment patches the name

private const int PERCENT_OF_JOBS_WITH_EMAIL_THREAD = 50;   // good: no comment needed
```

**3. The duplicate-check.** Where else does this fact already live — the enum's own docblock, a sibling field, the `assert` two lines below, the `{% props %}` line directly above? Keep it in one place, delete the copy.

```twig
{% props email, alignment = 'left' %}
{# email (Email) The email whose delivery is being reported ... #}   {# delete: restates props #}
```

**4. The density check — once, over the whole diff.** Count the survivors. If most new properties, constants or methods carry one, that density *is* the failure: a wall of individually-defensible comments buries the one or two that are load-bearing. More than a couple per change means you rationalized them one at a time. Cut back to the load-bearing ones.

**5. Cut it to the bone.** A comment that survives the first four is still too long. Keep only the words carrying the justification and delete the rest — the setup sentence restating what the code does, the second example, the reassuring aside. One line is the target; two is a lot.

Brevity is about *words, not syntax*. Trim the content, then keep whatever comment form the surrounding code uses in that slot — a comment above a class, enum, interface or trait stays a docblock (`/** */`) even when it is one sentence. Collapsing it to `//` is a formatting change, not a cut, and it breaks with every other type in the codebase.

```php
// Before — three sentences, only the middle one earns its place
/**
 * Writes the delivery columns straight to the row, without loading it. A delivery result arrives
 * in the messenger worker: there is no user behind it, and flushing there would commit whatever
 * else happens to be pending. A row that has since been deleted updates nothing, which is fine.
 */

// After
// Runs in the messenger worker, where an em->flush() would commit whatever else is pending.
```

**6. Say it literally.** What survives describes an operation, not an intention. Code, services, processes and third parties do not know, want, owe, decide, agree, or hand anything over — name the query, the request, the write, the dispatch, the header. The same goes for metaphor: no parcels, couriers or clocks starting.

```php
// Bad — "knows" gives a webhook an opinion, and settles nothing about what either one reports
// A delivery webhook can land first, and knows more than Postmark accepting the message did.

// Good — names what each one actually reports
// A delivery webhook reports what the recipient's server did; a 200 here only reports that
// Postmark accepted the message.
```

**7. Name it in the layer the fact belongs to.** Check 6 says name the operation. This says *which* operation, and the answer is: whichever one the comment's own justification is about.

A fact about persistence, ordering or I/O names the flush, the query, the dispatch — there the mechanism **is** the fact, and naming anything else loses it. A fact about what a service is for names the entity and the states it sets; rows, columns and flushes in that slot drag the reader down a layer and say less. Either way, name the specific effect, never a category of effect.

```php
// Good — the fact being recorded IS the flush, so the flush is named
// Runs in the messenger worker, where an em->flush() would commit whatever else is pending.

// Good — same reason: the obligation is the fact
/**
 * ...The caller is responsible for flushing.
 */

// Bad — the fact is what the class is for, so "row" is a layer too low, and "applies what
// Postmark reports" names no effect at all
/**
 * Applies what Postmark reports about an email we sent to the row it was recorded against.
 */

// Bad — "delivery columns" is a category rather than an effect, and how it saves is not what
// the class is for
/**
 * Loads the `Email` a delivery result names, sets its delivery columns, and flushes once.
 */

// Good — the entity, and the two states it actually sets
/**
 * Marks an `Email` we sent as delivered or bounced, from what Postmark's delivery webhook reports.
 */
```

## Slots that expect a comment

**A service class docblock.** One sentence saying what the service is for. This slot is expected to
be filled, so it is not held to check 1. Name what it does to the domain and where its input comes
from — and nothing else. Not the flush, not the repository, not the DTOs it takes, not the branch
where it finds nothing. Checks 5, 6 and 7 still bind it; check 7 has the worked example.

**A public service method docblock is not that slot.** It earns its place only for something the
signature cannot state — an obligation on the caller, an ordering requirement, a `@throws`.
`recordOutboundEmail()` carries "The caller is responsible for flushing" because nothing flushes for
you and an unflushed email never sends. `send(Email $email): void` needs nothing.

**Any repeated structural convention.** If the surrounding code consistently carries a structural comment in a given slot — a component's prop list, a fixed docblock format on every sibling class — match it. Consistency wins there, and a lone file breaking the pattern reads as an oversight. Check a sibling before deleting on the duplicate-check. This covers a *repeated structural* convention, not a one-off comment you found nearby.

## Rationalization → Reality

| Excuse | Reality |
|---|---|
| "They asked for it to be well-documented" | Documentation makes a reader fast, not slow. Narration slows them down. |
| "It's for a junior / on-call, spell it out" | Spelling out ordinary control flow patronizes them. The surprising part is what helps. |
| "It explains the why, not the what" | Then name which of the four justifications. "Why this field exists" is a definition in a why costume. |
| "It's a public API, the docstring should be complete" | Complete = purpose + non-obvious contract (units, ownership, error behaviour), not a walkthrough of the body. |
| "This constant needs a comment to say what it means" | Naming problem — check 2. |
| "Each one is individually defensible" | Check 4. Defensible-but-unnecessary is precisely the failure mode. |
| "It warns the next person about an edge case" | Only if the case exists. A comment about code nobody has written has nothing to anchor to and rots unread. |

## Red flags

- A comment on most of the new symbols in a diff
- A docblock restating an enum's docblock, a `{% props %}` line, or the method body beneath it
- Prose narrating what the code plainly does, however elegantly phrased
- A comment you'd defend as "the why" but can't map to one of check 1's four justifications
- A "mental model" essay for code that isn't complex
- Writing comments because the request said "document" or "explain"
- A comment giving code, a service or a third party an intention — knows, wants, owes, decides, hands off
- A sentence about what someone *would* need to do, a case that *would* apply, or a future extension

Before finishing any coding task, re-read every comment you wrote and run every check — especially when the task was "add comments."
