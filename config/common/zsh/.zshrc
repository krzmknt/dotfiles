# ===========================
# General
# ---------------------------
export LANG=en_US.UTF-8
export EDITOR=nvim

# PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/ghq/github.com/krzmknt/dotfiles/bin:$PATH"

# API Keys
[[ -f ~/keys/openai ]] && source ~/keys/openai
[[ -f ~/keys/anthropic ]] && source ~/keys/anthropic

# ===========================
# Prompt
# ---------------------------
# Enable colors in prompt
autoload -U colors && colors
setopt PROMPT_SUBST

# Simple prompt with yellow arrow (matching fish)
# Using 256-color yellow (178) which is close to #e2b86b
# Nerd Font chevron right (U+F054)
PROMPT=$'%F{178}\uf054 %f'

# Right prompt with AWS_PROFILE (matching fish)
RPROMPT='%F{178}${AWS_PROFILE:+[$AWS_PROFILE]}%f'

# ===========================
# Aliases
# ---------------------------
alias cat="bat"
alias dcu="dc up --build -d"
alias diff="colordiff"
alias l="eza -abBhHilS --git --icons"
alias v="nvim"

# ===========================
# Functions
# ---------------------------

# cd with auto ls
cd() {
  builtin cd "$@" && l
}

# tmux session management
tm() {
  if [[ -n "$1" ]]; then
    tmux attach-session -t "$1" || tmux new-session -s "$1"
  else
    tmux attach-session || tmux new-session
  fi
}

# Docker functions
dockerun() {
  local name=$1
  local image=$2
  local host="$name.docker"
  docker container stop $name > /dev/null 2>&1
  docker container rm $name > /dev/null 2>&1
  docker run --name $name --hostname $host -p 8080:8080 -it $image
}

dockerm() {
  local name=$1
  docker container stop $name > /dev/null 2>&1
  docker container rm $name > /dev/null 2>&1
}

# Clear screen and scrollback
cls() {
  clear
  if [[ -n "$TMUX" ]]; then
    tmux clear-history
  fi
  printf '\e]50;ClearScrollback\a'
}

# ===========================
# Cursor
# ---------------------------
# Bar cursor (like fish)
# 1=block blink, 2=block, 3=underline blink, 4=underline, 5=bar blink, 6=bar
echo -ne '\e[6 q'  # Set cursor to bar on startup

# ===========================
# Key Bindings
# ---------------------------
bindkey -e  # Emacs key bindings

# Alt + u - go up directory
up_directory() {
  cd ..
  zle reset-prompt
}
zle -N up_directory
bindkey '\eu' up_directory

# Ctrl + f - Launch nvim
launch_nvim() {
  BUFFER=""
  nvim
  zle reset-prompt
}
zle -N launch_nvim
bindkey '^f' launch_nvim

# ===========================
# mise
# ---------------------------
if [[ -f ~/.local/bin/mise ]]; then
  eval "$(~/.local/bin/mise activate zsh)"
fi

# ===========================
# ghq + fzf
# ---------------------------
ghq_fzf_repo() {
  local selected_repository=$(ghq list -p | sed "s|$(ghq root)/||" | fzf \
    --prompt="repositories > " \
    --preview="eza -la --icons --git $(ghq root)/{}" \
    --preview-window=right:50%)
  if [[ -n "$selected_repository" ]]; then
    cd "$(ghq root)/$selected_repository"
    echo "$selected_repository"
    zle reset-prompt
  fi
}
zle -N ghq_fzf_repo
bindkey '^g' ghq_fzf_repo

# ===========================
# workspace + fzf
# ---------------------------
workspace_fzf_repo() {
  local selected_repository=$(workspace list | sort --reverse | fzf \
    --prompt="workspaces > " \
    --preview="eza -la --icons --git {}" \
    --preview-window=right:50%)
  if [[ -n "$selected_repository" ]]; then
    cd "$selected_repository"
    echo "$selected_repository"
    zle reset-prompt
  fi
}
zle -N workspace_fzf_repo
bindkey '^w' workspace_fzf_repo


# ===========================
# History
# ---------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ===========================
# Completion
# ---------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ===========================
# Fish-like features (plugins)
# ---------------------------
# zsh-syntax-highlighting: colors for commands (blue=valid, red=invalid)
# zsh-autosuggestions: gray completion candidates

# Homebrew plugin paths
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# Syntax highlighting (must be loaded before autosuggestions)
if [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  # Colors similar to fish
  ZSH_HIGHLIGHT_STYLES[command]='fg=#4fa6ed'           # blue for valid commands
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=#4fa6ed'           # blue for builtins
  ZSH_HIGHLIGHT_STYLES[alias]='fg=#4fa6ed'             # blue for aliases
  ZSH_HIGHLIGHT_STYLES[function]='fg=#4fa6ed'          # blue for functions
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#e55561'     # red for invalid
  ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'      # paths
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#8ebd6b'  # green for strings
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#8ebd6b'  # green for strings
fi

# Autosuggestions (gray completion like fish)
if [[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a818e'  # gray color
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  # Right arrow to accept suggestion character by character
  bindkey '^[[C' forward-char              # Right arrow: accept one character
  bindkey '^[OC' forward-char              # Right arrow (alternate)
fi

# Accept full autosuggestion with End key or Ctrl+E
bindkey '^E' autosuggest-accept

# ===========================
# Startup
# ---------------------------
l && pwd


# >>> aws-profile-selector start >>>
awsps() {
  tmp=$(mktemp)
  aws-profile-selector "$@" --out "$tmp" || { rm -f "$tmp"; return; }
  prof=$(<"$tmp"); rm -f "$tmp"
  [ -z "$prof" ] && return
  export AWS_PROFILE="$prof"
  echo "AWS_PROFILE=$AWS_PROFILE"
}
bindkey -s '^T' 'awsps
'
# <<< aws-profile-selector end <<<


