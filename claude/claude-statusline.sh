#!/bin/bash

input=$(cat)

# Extract data
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
effort=$(jq -r '.effortLevel // empty' ~/.claude/settings.json 2>/dev/null)
effort="${effort:-high}"

# Get git branch
branch=$(git branch --show-current 2>/dev/null || echo "no-git")

# Build status line (using Nerd Font icons)
status="󰚩 $model | 󰊢 $branch | 󱗆 $effort"

if [ -n "$used" ]; then
  status="$status | Context: ${used}%"
fi

echo "$status"
