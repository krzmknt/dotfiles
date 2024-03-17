fish_add_path /opt/homebrew/bin


# ===========================
# General
# ---------------------------
set --global fish_prompt_pwd_dir_length 3


# ===========================
# Color
# ---------------------------
export LSCOLORS=Gxfxcxdxbxegedabagacad

set --local dark_blue                    4a5e60 #4a5e60
set --local blue                         006cc6 #006cc6

set --local red                          f00050 #f00050
set --local orange                       E17A47 #E17A47
set --local yellow                       e0c050 #E0C050
set --local green                        00a050 #00a050
set --local dark_green                   344E5C #344E5C

set --local purple                       ae81ff #ae81ff
set --local water                        006cc6 #006cc6
set --local duck_blue                    006cc6 #006cc6
set --local pink                         c600c0 #c600c0
set --local light_pink                   f8bbf6 #f8bbf6
set --local night_blue                   255D83 #255D83

set --local framingo                     ff687e #ff687e

set --global white                       ffffff #ffffff
set --global black                       000000 #000000
set --global color_dark                  303030 #303030
set --global color_light                 dddddd #dddddd
set --global color_discreet              757575 #757575

set --global color_main                  $night_blue
set --global color_main_light            $blue
set --global color_warning               $framingo
set --global color_git_main              $green
set --global color_git_dirty             $yellow
set --global fish_color_normal           $white
set --global fish_color_autosuggestion   $color_discreet
set --global fish_color_cancel           --background=$color_main
set --global fish_color_command          $color_main_light
set --global fish_color_comment          $color_discreet
set --global fish_color_end              $color_main_light
set --global fish_color_error            $red
set --global fish_color_escape           $color_discreet
set --global fish_color_match            --background=$color_main_light
set --global fish_color_operator         $light_pink
set --global fish_color_param            $light_pink
set --global fish_color_search_match     --background=$color_main
set --global fish_color_selection        --background=$dark_green
set --global fish_color_quote            $light_pink
set --global fish_pager_color_progress   $color_main_light
set --global fish_pager_color_completion $white
set --global fish_pager_color_prefix     $color_main_light


# ===========================
# Aliases
# ---------------------------
alias cat   "bat"
alias d     "docker"
alias dc    "docker-compose"
alias dcd   "dc down"
alias dcl   "dc logs"
alias dcu   "dc up --build -d"
alias diff  "colordiff"
alias dl    "docker ps -a"
alias ghw   "gh repo view --web"
alias g     "git"
alias la    "exa -abBhHilS --git --icons"
alias poa   "poetry add"
alias por   "poetry run"
alias pos   "poetry show"
alias v     "nvim"
alias vi    "nvim"
alias vim   "nvim"

function config
  set plugin $argv[1]
  vim ~/dotfiles/config/$plugin

  switch $plugin
    case fish
      set refresh_cmd "source ~/dotfiles/config/fish/.config/fish/config.fish"
    case tmux
      set refresh_cmd "tmux source-file ~/.tmux.conf"
    case skhd
      set refresh_cmd "skhd --reload"
    case yabai
      set refresh_cmd "brew services restart yabai"
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

function awsmc
    open "https://console.aws.amazon.com/console/home?region=us-east-1"
    oathtool --totp --base32 CX2FURPJNXZN3QUISRSFMHSWHVAWTMDIWLKI3BFRWXKPUR3VDMI4GBNNFZKXI3ZX | pbcopy
end


# ===========================
# AtCoder
# ---------------------------
function t
    set -l task $argv[1]
    oj test -c "poetry run python ./$task/main.py" -S -d ./$task/tests/
end


function s
    # Not available for the contest before ABC020 (URL rule does not compatible)
    set -l task $argv[1]

    # If some test case failed, cancel the submit
    t $task
    if test $status = 1
        echo "[ERROR] test failed"
        return 1
    end

    set -l interpreter "pypy"
    set -l contest (basename (pwd))
    set -l contest_type (echo $contest | sed "s/.\{3\}\$//")
    set -l confirmation_phrase $contest_type$task
    echo $confirmation_phrase | acc submit --task $contest"_"$task $task/main.py -- --guess-python-interpreter $interpreter
end




# ===========================
# asdf
# ---------------------------
source /opt/homebrew/opt/asdf/libexec/asdf.fish


# ===========================
# ghq + peco
# ---------------------------
function ghq_peco_repo
  set selected_repository (ghq list -p | peco --prompt="repositories > " --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo "$selected_repository"
    commandline -f repaint
  end
end

# fish key binding
function fish_user_key_bindings
  bind \cg ghq_peco_repo
end
