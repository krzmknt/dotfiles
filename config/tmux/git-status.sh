#!/opt/homebrew/bin/bash
cd "$1" 2>/dev/null || exit

branch=$(git branch --show-current 2>/dev/null)
if [ -z "$branch" ]; then
  exit
fi

# Diff stats (local changes)
added=$(git diff --numstat 2>/dev/null | awk '{s+=$1}END{print s+0}')
removed=$(git diff --numstat 2>/dev/null | awk '{s+=$2}END{print s+0}')

# Commits ahead/behind remote
ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo "0")

# Icons (same as Neovim icons.lua)
icon_branch=$'\ue0a0'
icon_added=$'\uf457'
icon_removed=$'\uf458'

# Colors: gray=#9ca3af, green=#00ff7f, red=#ff6b6b, cyan=#00ffff
output="#[fg=#9ca3af]$icon_branch $branch"
output+=" #[fg=#00ff7f]$icon_added $added"
output+=" #[fg=#ff6b6b]$icon_removed $removed"

# Only show ahead/behind if there's a difference
if [ "$ahead" != "0" ] || [ "$behind" != "0" ]; then
  output+=" #[fg=#00ffff]↑$ahead ↓$behind"
fi

echo "$output"
