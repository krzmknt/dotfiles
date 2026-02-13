#!/bin/bash
# Check input method and update tmux pane border color
# Red border = Japanese input active (warning)
# Normal border = English input (ABC)

im=$(im-select 2>/dev/null)

if [[ "$im" != "com.apple.keylayout.ABC" ]]; then
  tmux set -g pane-active-border-style "bg=default fg=red" 2>/dev/null
  echo "#[fg=red]あ"
else
  tmux set -g pane-active-border-style "bg=default fg=colour75" 2>/dev/null
fi
