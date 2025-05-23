fish_add_path /opt/homebrew/bin

source ~/keys/openai
source ~/keys/anthropic

# ===========================
# General
# ---------------------------
set --global fish_prompt_pwd_dir_length 3

set -Ux PATH $PATH /Users/krzmknt/.local/share/mise/installs/go/1.20.4/bin/efm-langserver

# ===========================
# Color
# ---------------------------
export LSCOLORS=Gxfxcxdxbxegedabagacad

# one dark
set --global COLOR_BG0 "#1f2329"
set --global COLOR_BG1 "#282c34"
set --global COLOR_BG2 "#30363f"
set --global COLOR_BG3 "#323641"
set --global COLOR_BG_BLUE "#61afef"
set --global COLOR_BG_D "#181b20"
set --global COLOR_BG_YELLOW "#e8c88c"
set --global COLOR_BLACK "#0e1013"
set --global COLOR_BLUE "#4fa6ed"
set --global COLOR_CYAN "#48b0bd"
set --global COLOR_DARK_CYAN "#266269"
set --global COLOR_DARK_PURPLE "#7e3992"
set --global COLOR_DARK_RED "#8b3434"
set --global COLOR_DARK_YELLOW "#835d1a"
set --global COLOR_DIFF_ADD "#272e23"
set --global COLOR_DIFF_CHANGE "#172a3a"
set --global COLOR_DIFF_DELETE "#2d2223"
set --global COLOR_DIFF_TEXT "#274964"
set --global COLOR_FG "#a0a8b7"
set --global COLOR_GREEN "#8ebd6b"
set --global COLOR_GREY "#535965"
set --global COLOR_LIGHT_GREY "#7a818e"
set --global COLOR_NONE "none"
set --global COLOR_ORANGE "#cc9057"
set --global COLOR_PURPLE "#bf68d9"
set --global COLOR_RED "#e55561"
set --global COLOR_YELLOW "#e2b86b"

set --global color_dark                  $COLOR_BG0
set --global color_lightdark             $COLOR_BG1
set --global color_light                 "#ffffff"
set --global color_discreet              $COLOR_LIGHT_GREY
set --global color_main                  $COLOR_DARK_CYAN
set --global color_main_light            $COLOR_BG_BLUE
set --global color_warning               $COLOR_RED
set --global color_git_main              $COLOR_BG_BLUE
set --global color_git_dirty             $COLOR_YELLOW

set --global fish_color_normal           "#ffffff"
set --global fish_color_autosuggestion   $COLOR_LIGHT_GREY
set --global fish_color_cancel           --background=$COLOR_DARK_CYAN
set --global fish_color_command          $COLOR_BG_BLUE
set --global fish_color_comment          $COLOR_LIGHT_GREY
set --global fish_color_end              $COLOR_BG_BLUE
set --global fish_color_error            $COLOR_RED
set --global fish_color_escape           $COLOR_LIGHT_GREY
set --global fish_color_match            --background=$COLOR_BG_BLUE

set --global fish_color_operator         $light_pink
set --global fish_color_param            $light_pink

set --global fish_color_search_match     --background=$color_main
set --global fish_color_selection        --background=$dark_green
set --global fish_color_quote            $light_pink
set --global fish_pager_color_progress   $color_main_light
set --global fish_pager_color_completion "#ffffff"
set --global fish_pager_color_prefix     $color_main_light

set -x EXA_COLORS "su=38;5;243:da=38;5;243:di=38;5;75:fi=38;5;250:ln=38;5;117:*.md=38;5;176:*.js=38;5;215:*.py=38;5;114:*.rb=38;5;204"

# ===========================
# Aliases
# ---------------------------
alias cat   "bat"
alias d     "docker"
alias dc    "docker-compose"
alias dcd   "dc down"
alias nr    "npm run"
alias dcl   "dc logs"
alias dcu   "dc up --build -d"
alias diff  "colordiff"
alias dl    "docker ps -a"
alias g     "git"
alias gd    "git diff"
alias ghw   "gh repo view --web"
alias gl    "git log"
alias gs    "git status"
alias la    "eza -abBhHilS --git --icons"
alias t     "todo.sh"
alias v     "nvim"
alias vi    "nvim"
alias vim   "nvim"
alias ws    "workspace"

function check_git_dir
    if test -d .git
        return 0
    else
        echo ".git directory not found" >&2
        exit 1
    end
end

function ga
  check_git_dir
  git add .
end

function gc
  check_git_dir
  git commit $argv
end

function gp
  check_git_dir
  git push
end

function config
  set plugin $argv[1]
  vim ~/ghq/github.com/krzmknt/dotfiles/config/$plugin

  switch $plugin
    case fish
      set refresh_cmd "source ~/ghq/github.com/krzmknt/dotfiles/config/fish/.config/fish/config.fish"
    case tmux
      set refresh_cmd "tmux source-file ~/.tmux.conf"
    case skhd
      set refresh_cmd "skhd --reload"
    case yabai
      set refresh_cmd "yabai --restart-service"
  end
  echo $refresh_cmd
  eval $refresh_cmd
end

function cd
  builtin cd $argv; and la
end

function tm
  if [ -n "{$argv}" ]
    tmux attach-session -t {$argv} || tmux new-session -s {$argv}
  else
    tmux attach-session || tmux new-session
  end
end

function dockerun
    set -l name $argv[1]
    set -l image $argv[2]
    set -l host "$name.docker"
    docker container stop $name > /dev/null 2>&1
    docker container rm $name > /dev/null 2>&1
    docker run --name $name --hostname $host -p 8080:8080 -it $image
end

function dockerm
  set -l name $argv[1]
  docker container stop $name > /dev/null 2>&1
  docker container rm $name > /dev/null 2>&1
end


# ===========================
# Shortcuts
# ---------------------------

function up_directory
  cd ..
  commandline -f repaint
end

# Alt + u
bind \eu up_directory


# ===========================
# asdf
# ---------------------------
# Ver. 0.14.0 から tmux 利用時に不具合（pathがプリペンドされない）
# -> mise に移行
# source /opt/homebrew/opt/asdf/libexec/asdf.fish

# ===========================
# mise
# ---------------------------
~/.local/bin/mise activate fish | source


# ===========================
# ghq + peco
# ---------------------------
function ghq_peco_repo
  set selected_repository (ghq list -p | sed "s|$(ghq root)/||" | peco --prompt="repositories > " --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $(ghq root)/$selected_repository
    echo "$selected_repository"
    commandline -f repaint
  end
end

# fish key binding
function fish_user_key_bindings
  bind \cg ghq_peco_repo
end


# ===========================
# workspace + peco
# ---------------------------
function workspace_peco_repo
  set selected_repository (workspace list | sort --reverse | peco --prompt="workspaces > " --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo "$selected_repository"
    commandline -f repaint
  end
end
bind \cw workspace_peco_repo


# ===========================
# AWS Profile selector
# ---------------------------

# Ctrl + T キーで aws_profile_selector 関数を実行
function bind_aws_profile_selector
    aws_profile_selector
    commandline -f repaint
end

# キーバインディングの設定
bind \ct bind_aws_profile_selector
