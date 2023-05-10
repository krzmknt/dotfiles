# -----------------------------------------------
# General
# -----------------------------------------------
alias la "exa -abBhHilS --git --icons"
alias diff colordiff
alias c "g++ -o $argv $argv[1].cpp && ./$argv[1]"
alias cat bat
set --global fish_prompt_pwd_dir_length 3


function config
  vim "$HOME/.config/fish/config.fish"
  source ~/.config/fish/config.fish
end


function cd
  builtin cd $argv; and la
end




# -----------------------------------------------
# Color
# -----------------------------------------------
export LSCOLORS=Gxfxcxdxbxegedabagacad

set --local dark_blue                    4a5e60
set --local blue                         00bcc6
set --local red                          f92672
set --local orange                       fd971f
set --local purple                       ae81ff
set --local water                        66d9ef
set --local duck_blue                    007394

set --local green                        00c694
set --local dark_green                   287480
set --local pink                         c600c0
set --local light_pink                   f8bbf6
set --local yellow                       f7ce3e


set --global white                       ffffff
set --global black                       000000

set --global color_dark                  505050
set --global color_light                 dddddd
set --global color_discreet              757575
set --global color_main                  $duck_blue
set --global color_main_light            $blue
set --global color_warning               $red

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




# -----------------------------------------------
# vim
# -----------------------------------------------
alias v nvim
alias vi nvim
alias vim nvim




# -----------------------------------------------
# git
# -----------------------------------------------
function ghw
  gh repo view --web
end




# -----------------------------------------------
# tmux
# -----------------------------------------------
function config_tm
  vim ~/.tmux.conf
  tmux source ~/.tmux.conf
end


function tm
  if [ -n "{$argv}" ]
    tmux attach-session -t {$argv} || tmux new-session -s {$argv}
  else
    tmux attach-session || tmux new-session
  end
end




# -----------------------------------------------
# docker
# -----------------------------------------------
alias d docker
alias dl "docker ps -a"
alias dc docker-compose


function dcd
  dc down
end


function dcu
  dc up --build -d
end


function dcl
  dc logs
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
eval (direnv hook fish)




# -----------------------------------------------
# aws
# -----------------------------------------------
function awsmc
    open "https://console.aws.amazon.com/console/home?region=us-east-1"
    oathtool --totp --base32 CX2FURPJNXZN3QUISRSFMHSWHVAWTMDIWLKI3BFRWXKPUR3VDMI4GBNNFZKXI3ZX | pbcopy
end

# -----------------------------------------------
# Poetry
# -----------------------------------------------
alias por "poetry run"
alias poa "poetry add"
alias pos "poetry show"


# -----------------------------------------------
# atcoder
# -----------------------------------------------
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
        echo "Error: test failed"
        return 1
    end

    set -l interpreter "pypy"
    set -l contest (basename (pwd))
    set -l contest_type (echo $contest | sed "s/.\{3\}\$//")
    set -l confirmation_phrase $contest_type$task
    echo $confirmation_phrase | acc submit --task $contest"_"$task $task/main.py -- --guess-python-interpreter $interpreter
end


function o
    set contest (basename (pwd))
    for d in (ls -d */);

        # URL 規則の例外処理
        if test $d = "ex/"
            set d "h/"
        end

        open "https://atcoder.jp/contests/$contest/tasks/$contest""_$d"
    end
end



