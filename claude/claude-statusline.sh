#!/bin/bash

input=$(cat)

# Extract data
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

context_label="Context:"
if [ -n "$FTNT_CLAUDE_CONTEXT_WINDOW" ] && [ -n "$context_size" ] && [ -n "$used" ]; then
  used=$(( used * context_size / FTNT_CLAUDE_CONTEXT_WINDOW ))
  ctx_k=$(( FTNT_CLAUDE_CONTEXT_WINDOW / 1024 ))
  context_label="Context (${ctx_k}k):"
fi

# Get git branch
branch=$(git branch --show-current 2>/dev/null || echo "no-git")

# Build status line (using Nerd Font icons)
status="󰚩 $model | 󰊢 $branch"

if [ -n "$used" ]; then
  # Dot icons (Nerd Font octicons)
  dot_fill=$''
  dot_empty=$''

  # ANSI colors
  green='\033[32m'
  yellow='\033[33m'
  red='\033[31m'
  reset='\033[0m'

  # Calculate filled dots (out of 10)
  filled=$(( used * 10 / 100 ))
  unfilled=$(( 10 - filled ))

  # Pick color based on usage threshold
  if [ "$used" -le 50 ]; then
    color="$green"
  elif [ "$used" -le 75 ]; then
    color="$yellow"
  else
    color="$red"
  fi

  # Build dot string
  dots=""
  for (( i=0; i<filled; i++ )); do dots+="$dot_fill"; done
  for (( i=0; i<unfilled; i++ )); do dots+="$dot_empty"; done

  status="$status | ${context_label} ${color}${dots} ${used}%${reset}"
fi

echo -e "$status"
