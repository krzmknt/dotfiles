#!/opt/homebrew/bin/bash
cd "$1" 2>/dev/null || exit

branch=$(git branch --show-current 2>/dev/null)
if [ -z "$branch" ]; then
  exit
fi

# Diff stats (line changes)
added=$(git diff --numstat 2>/dev/null | awk '{s+=$1}END{print s+0}')
removed=$(git diff --numstat 2>/dev/null | awk '{s+=$2}END{print s+0}')

# File status counts
staged=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
modified=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

# Commits ahead/behind remote
ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null || echo "0")
behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null || echo "0")

# PR count (cached, updated every 5 minutes)
dir_hash=$(echo "$1" | md5)
pr_cache_file="/tmp/gh-pr-count-$dir_hash"
pr_count="0"

if [ -f "$pr_cache_file" ]; then
  last_update=$(stat -f %m "$pr_cache_file" 2>/dev/null || echo "0")
  now=$(date +%s)
  diff=$((now - last_update))
  if [ "$diff" -lt 300 ]; then
    pr_count=$(cat "$pr_cache_file")
  else
    pr_count=$(gh pr list --state open --json number --jq 'length' 2>/dev/null || echo "0")
    echo "$pr_count" > "$pr_cache_file"
  fi
else
  pr_count=$(gh pr list --state open --json number --jq 'length' 2>/dev/null || echo "0")
  echo "$pr_count" > "$pr_cache_file"
fi

# Icons (same as Neovim icons.lua)
icon_branch=$'\ue0a0'
icon_added=$'\uf457'
icon_removed=$'\uf458'
icon_pr=$'\uf407'
icon_staged=$'\uf00c'    # check mark
icon_modified=$'\uf040'  # pencil
icon_untracked=$'\uf059' # question mark

# Colors
output="#[fg=#9ca3af]$icon_branch $branch"

# Show file status (staged, modified, untracked)
if [ "$staged" != "0" ]; then
  output+=" #[fg=#00ff7f]$icon_staged $staged"
fi
if [ "$modified" != "0" ]; then
  output+=" #[fg=#ffa500]$icon_modified $modified"
fi
if [ "$untracked" != "0" ]; then
  output+=" #[fg=#ff6b6b]$icon_untracked $untracked"
fi

# Show line diff
output+=" #[fg=#00ff7f]$icon_added $added"
output+=" #[fg=#ff6b6b]$icon_removed $removed"

# Only show ahead/behind if there's a difference
if [ "$ahead" != "0" ] || [ "$behind" != "0" ]; then
  output+=" #[fg=#00ffff]↑$ahead ↓$behind"
fi

# Show PR count if > 0
if [ "$pr_count" != "0" ]; then
  output+=" #[fg=#e879f9]$icon_pr $pr_count"
fi

echo "$output"
