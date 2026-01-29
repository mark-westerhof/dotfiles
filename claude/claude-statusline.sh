#!/bin/bash

input=$(cat)

# Extract data
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Get git branch
branch=$(git branch --show-current 2>/dev/null || echo "no-git")

# Build status line
status="$model | $branch"

if [ -n "$used" ]; then
  status="$status | Context: ${used}%"
fi

echo "$status"
