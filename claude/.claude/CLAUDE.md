# CLI tool overrides

IMPORTANT: The following CLI tools MUST be used via the Bash tool instead of the built-in equivalents:

- **ripgrep** (`rg`) — use via Bash instead of the built-in Grep tool for all content searches
- **fd** — use via Bash instead of the built-in Glob tool for all file finding
- **sd** — use via Bash instead of the Edit tool for bulk find-and-replace across files
- **bun** — use instead of `node`/`npm` for running scripts, installing packages, and executing JS/TS
- **jq** — use for JSON processing in shell pipelines
- **GNU parallel** — use for concurrent shell tasks when beneficial
