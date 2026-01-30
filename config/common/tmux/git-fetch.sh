#!/opt/homebrew/bin/bash
# Auto-fetch git repos in background
# Only fetches if last fetch was >5 minutes ago

cd "$1" 2>/dev/null || exit

# Check if it's a git repo
git rev-parse --git-dir >/dev/null 2>&1 || exit

# Create hash of directory path for unique temp file
dir_hash=$(echo "$1" | md5)
last_fetch_file="/tmp/git-fetch-$dir_hash"

# Only fetch if >5 minutes (300 seconds) since last fetch
if [ -f "$last_fetch_file" ]; then
  last_fetch=$(stat -f %m "$last_fetch_file" 2>/dev/null || echo "0")
  now=$(date +%s)
  diff=$((now - last_fetch))
  if [ "$diff" -lt 300 ]; then
    exit 0
  fi
fi

# Fetch in background and update timestamp
git fetch --quiet 2>/dev/null &
touch "$last_fetch_file"
