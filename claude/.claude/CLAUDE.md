# CLI tool overrides

IMPORTANT: The following CLI tools MUST be used via the Bash tool instead of the built-in equivalents:

- **ripgrep** (`rg`) — use via Bash instead of the built-in Grep tool for all content searches
- **fd** — use via Bash instead of the built-in Glob tool for all file finding
- **sd** — use via Bash instead of the Edit tool for bulk find-and-replace across files
- **bun** — use instead of `node`/`npm` for running scripts, installing packages, and executing JS/TS
- **jq** — use for JSON processing in shell pipelines
- **GNU parallel** — use for concurrent shell tasks when beneficial

# Writing

IMPORTANT: Explain mechanisms literally. Name the actual class, method, file, table, column or
command, and say what it does. Do not reach for a metaphor to describe how code works — no parcels,
luggage tags, post offices or couriers — unless I ask for an analogy.

## No personification

Code, services, processes and third parties have no intentions. They do not owe, want, know,
promise, decide, agree, care, or hand anything over. Name the operation instead: a query, an HTTP
request, a write, a dispatch, a return value, a header.

This applies to code comments as much as to prose.

## Banned phrases

These say nothing. Never use them:

- "falls out for free", "comes for free", "for free"
- "just works", "simply", "trivially"
- "under the hood", "behind the scenes"
- "moving parts", "surface area", "altitude", "at the right layer"
- "evaporates", "melts away", "disappears as a side effect"
- "it's a wash", "the sweet spot", "best of both worlds"
- "owes", "knows", "wants", "decides", "is aware", "is happy" — of code or a service
- "hands off", "hands over", "takes over", "the clock starts", "is now X's problem"

## Say the concrete thing instead

- Bad: "The ordering constraint evaporates."
  Good: "`recordOutboundEmail()` no longer has to wait for a database id, because the identifier is
  generated in PHP before the row is saved."
- Bad: "This falls out of step 6 for free."
  Good: "Step 6 already needs a self-generated identifier to match bounce webhooks, so no extra work
  is required here."
- Bad: "Cleaner separation of concerns."
  Good: "`Emailer` would no longer need `EntityManagerInterface`."
- Bad: "The worker still owes MySQL a round trip after Postmark already has the message."
  Good: "After Postmark's API returns 200, the worker still runs a SELECT and an UPDATE. Postmark
  can start delivering during those two queries."
- Bad: "A delivery webhook can land first, and knows more than Postmark accepting the message did."
  Good: "A delivery webhook reports what the recipient's server did; Postmark returning 200 only
  reports that Postmark accepted the message."

## Claims

State what I would have to check to disprove you. If you have not verified something, say so in the
same sentence as the claim, not in a footnote. Prefer a measurement or a file:line reference over an
adjective.
