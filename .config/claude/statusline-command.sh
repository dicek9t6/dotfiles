#!/usr/bin/env bash
# Claude Code status line: model, git branch, token usage, rate limits, session info

input=$(cat)

# -- Model --
model=$(echo "$input" | jq -r '.model.display_name // empty')

# -- Session name (only when explicitly set via /rename) --
session_name=$(echo "$input" | jq -r '.session_name // empty')

# -- Git branch (from cwd in the input, skip optional locks) --
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
git_branch=""
if [ -n "$cwd" ]; then
  git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# -- Token context usage --
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# -- Output tokens from last response (rough proxy for response size) --
out_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')

# -- Rate limits --
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

SEP=" | "
parts=()

# Model
[ -n "$model" ] && parts+=("$model")

# Git branch
[ -n "$git_branch" ] && parts+=("branch: $git_branch")

# Context usage
if [ -n "$used" ]; then
  parts+=("$(printf 'ctx: %.0f%%' "$used")")
fi

# Output tokens from last turn
if [ -n "$out_tokens" ] && [ "$out_tokens" -gt 0 ] 2>/dev/null; then
  parts+=("$(printf 'out: %d tok' "$out_tokens")")
fi

# Rate limits (only shown when data is present)
rate_parts=""
if [ -n "$five_hour" ]; then
  rate_parts="$(printf '5h: %.0f%%' "$five_hour")"
fi
if [ -n "$seven_day" ]; then
  [ -n "$rate_parts" ] && rate_parts="$rate_parts  $(printf '7d: %.0f%%' "$seven_day")" \
    || rate_parts="$(printf '7d: %.0f%%' "$seven_day")"
fi
[ -n "$rate_parts" ] && parts+=("$rate_parts")

# Session name
[ -n "$session_name" ] && parts+=("session: $session_name")

# Join and print
result=""
for part in "${parts[@]}"; do
  [ -z "$result" ] && result="$part" || result="$result$SEP$part"
done

printf '%s' "$result"
