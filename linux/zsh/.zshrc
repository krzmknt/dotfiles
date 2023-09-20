########################################
# Zplug
. ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Enable asynchronmous process
zplug "mafredri/zsh-async"

# Syntax highlight
zplug "zsh-users/zsh-syntax-highlighting"

zplug "zsh-users/zsh-history-substring-search"

zplug "zsh-users/zsh-autosuggestions"

zplug "zsh-users/zsh-completions"

zplug "chrissicool/zsh-256color"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load


########################################
# Environment Variables
# export LANG=ja_JP.UTF-8

# Enable color usage
autoload -Uz colors
colors

# Use Emacs-like key bindings
bindkey -e

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Specify word delimiters
autoload -Uz select-word-style
select-word-style default
# Characters specified here are treated as word delimiters
# / is also treated as a delimiter, so ^W deletes one directory
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified


########################################
# Completion
# Enable completion feature
autoload -Uz compinit
compinit

# Case-insensitive matching for completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Do not complete the current directory after ../
zstyle ':completion:*' ignore-parents parent pwd ..

# Complete command names after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Complete process names for ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# Options
# Allow displaying of Japanese filenames
setopt print_eight_bit

# Disable beep
setopt no_beep

# Disable flow control
setopt no_flow_control

# Do not exit zsh with Ctrl+D
setopt ignore_eof

# Treat everything after '#' as comment
setopt interactive_comments

# cd into directories just by typing their names
setopt auto_cd

# Automatically pushd after cd
setopt auto_pushd
# Do not add duplicate directories
setopt pushd_ignore_dups

# Share history among zsh instances
setopt share_history

# Do not keep duplicate commands in history
setopt hist_ignore_all_dups

# Do not keep commands starting with a space in history
setopt hist_ignore_space

# Remove extra spaces when saving in history
setopt hist_reduce_blanks

# Use advanced wildcard expansion
setopt extended_glob


########################################
# Aliases
alias l='exa -abBhHilS --git --icons'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias vim='nvim'

# Enable aliases after sudo
alias sudo='sudo '

# Global aliases
alias -g L='| less'
alias -g G='| grep'

# Copy standard output to clipboard with C
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi


function cd {
  builtin cd $1 && l
}


########################################
# Keybinds
ghq_peco() {
  selected_repo="$(ghq list -p | peco --prompt='repositories > ')"
  if [ ! -z "$selected_repo" ]; then
    cd "$selected_repo"
  fi
  zle reset-prompt
}
zle -N ghq_peco
bindkey '^G' ghq_peco

function _git_status() {
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo git status --short -branch
        git status --short --branch
    fi
    zle reset-prompt
}

zle -N git_status _git_status
bindkey '^S' git_status

function _git_log() {
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo git log --graph --oneline
        git log --graph --oneline
    fi
    zle reset-prompt
}
zle -N git_log _git_log
bindkey '^L' git_log


function tm() {
  if [ -n $1 ]; then
    tmux attach-session -t $1 || tmux new-session -s $1
  else
    tmux attach-session || tmux new-session
  fi
}





########################################
# Bootstraps
. /home/krzmknt/.asdf/asdf.sh
eval "source <(/usr/local/bin/starship init zsh --print-full-init)"
export "PATH=$HOME/.asdf/installs/rust/1.72.1/bin/:$PATH"
export GOPATH=$(go env GOPATH)
export PATH=$GOPATH/bin:$PATH
