#!/usr/bin/env bash
# PreToolUse(Edit|Write) hook: blocks edits to .php/.twig/*_controller.ts
# files until the matching well-good-* skill has been invoked at least once
# this session. Paired hook: well-good-mark.sh (PostToolUse Skill), which
# drops the marker file this checks for.

payload=$(cat)
session_id=$(printf '%s' "$payload" | jq -r '.session_id // ""')
file_path=$(printf '%s' "$payload" | jq -r '.tool_input.file_path // ""')

skill=""
case "$file_path" in
    *.php) skill="well-good-php" ;;
    *.twig) skill="well-good-twig" ;;
    *_controller.ts) skill="well-good-stimulus" ;;
esac

if [ -n "$skill" ] && [ ! -f "/tmp/claude-wellgood-markers/$session_id/$skill.marker" ]; then
    jq -n --arg skill "$skill" --arg path "$file_path" '{
        hookSpecificOutput: {
            hookEventName: "PreToolUse",
            permissionDecision: "deny",
            permissionDecisionReason: ("Invoke the " + $skill + " skill before editing " + $path + " (once per session) - it is listed in your available skills. Then retry this edit.")
        }
    }'
    exit 0
fi

exit 0
