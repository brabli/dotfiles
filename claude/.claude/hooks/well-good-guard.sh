#!/usr/bin/env bash
# PreToolUse(Bash|Edit|Write) hook: blocks a source edit until every well-good-*
# skill that applies to it has been invoked recently. Language skills key off the
# extension; well-good-comments applies to anything that can carry a comment, so
# a .php edit needs both.
# Paired hook: well-good-mark.sh (PostToolUse Skill), which drops the markers.

# A skill invoked hours ago has stopped shaping what gets written, so markers go stale.
MARKER_TTL_MINUTES=45

CODE_EXT='php|twig|ts|tsx|js|jsx|css|scss|sh|sql|yaml|yml|neon'

payload=$(cat)
session_id=$(printf '%s' "$payload" | jq -r '.session_id // ""')
paths=$(printf '%s' "$payload" | jq -r '.tool_input.file_path // ""')

# Bash carries the path inside the command, so a sign of writing is required too:
# reading a file with cat, grep or sed -n must not demand a skill.
if [ -z "$paths" ]; then
    command=$(printf '%s' "$payload" | jq -r '.tool_input.command // ""')

    if printf '%s' "$command" | grep -qE "sed -i|[[:space:]]tee[[:space:]]|>>?[[:space:]]*[^[:space:]|&]+\.($CODE_EXT)\b|\.write\(|open\([^)]*[\"']w[\"']|^[[:space:]]*(mv|cp|rm)[[:space:]]"; then
        paths=$(printf '%s' "$command" | grep -oE "[[:alnum:]_./-]+\.($CODE_EXT)\b" | sort -u)
    fi
fi

[ -z "$paths" ] && exit 0

skills=""
for path in $paths; do
    case "$path" in
        *.php) skills="$skills well-good-php" ;;
        *.twig) skills="$skills well-good-twig" ;;
        *_controller.ts) skills="$skills well-good-stimulus" ;;
    esac
    skills="$skills well-good-comments"
done

for skill in $(printf '%s\n' $skills | sort -u); do
    marker="/tmp/claude-wellgood-markers/$session_id/$skill.marker"

    if [ -f "$marker" ] && [ -z "$(find "$marker" -mmin +"$MARKER_TTL_MINUTES" 2>/dev/null)" ]; then
        continue
    fi

    jq -n --arg skill "$skill" --arg path "$(printf '%s' "$paths" | tr '\n' ' ')" '{
        hookSpecificOutput: {
            hookEventName: "PreToolUse",
            permissionDecision: "deny",
            permissionDecisionReason: ("Invoke the " + $skill + " skill before editing " + $path + " - it is listed in your available skills. Re-read it, then retry this edit and apply its checks to what you write.")
        }
    }'
    exit 0
done

exit 0
