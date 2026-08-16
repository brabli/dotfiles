#!/usr/bin/env bash
# PostToolUse(Skill) hook: records that a well-good-* skill was invoked this
# session, so well-good-guard.sh (PreToolUse Edit|Write) knows it's safe to
# allow edits to matching files. Paired hook: well-good-guard.sh.

payload=$(cat)
session_id=$(printf '%s' "$payload" | jq -r '.session_id // ""')
skill=$(printf '%s' "$payload" | jq -r '.tool_input.skill // ""')

case "$skill" in
    well-good-php|well-good-twig|well-good-stimulus)
        marker_dir="/tmp/claude-wellgood-markers/$session_id"
        mkdir -p "$marker_dir"
        touch "$marker_dir/$skill.marker"
        ;;
esac

exit 0
