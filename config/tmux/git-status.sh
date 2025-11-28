#!/opt/homebrew/bin/bash
cd "$1" 2>/dev/null || exit

branch=$(git branch --show-current 2>/dev/null)
if [ -z "$branch" ]; then
  exit
fi

added=$(git diff --numstat 2>/dev/null | awk '{s+=$1}END{print s+0}')
removed=$(git diff --numstat 2>/dev/null | awk '{s+=$2}END{print s+0}')

# Icons (same as Neovim icons.lua)
# branch: U+E0A0, added: U+F457, removed: U+F458
icon_branch=$'\ue0a0'
icon_added=$'\uf457'
icon_removed=$'\uf458'

# Colors: gray=#9ca3af, green=#00ff7f, red=#ff6b6b
echo "#[fg=#9ca3af]$icon_branch $branch #[fg=#00ff7f]$icon_added $added #[fg=#ff6b6b]$icon_removed $removed"
