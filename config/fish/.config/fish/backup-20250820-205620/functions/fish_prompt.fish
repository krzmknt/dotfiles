
# ===============================================
# Variables

set last_status

set left_half_circle ''
set right_half_circle ''

# ===============================================
# Prompt

function fish_prompt
    set_color $COLOR_YELLOW
    printf '  '
    set_color normal
end

function fish_right_prompt
    set_color $COLOR_YELLOW
    echo -n [$AWS_PROFILE]
    set_color normal
end

function fish_prompt_old
    set last_status $status

    # Left top
    set_color $color_dark
    # printf '\n╭─'
    printf '\n '
    set_color normal

    # Prompt body
    _prompt_directory
    if [ $AWS_PROFILE ]
        _prompt_aws_profile
    end
    _prompt_username
    _prompt_git

    # Left_bottom
    set_color $color_dark
    # printf '\n╰─ '
    set_color $COLOR_YELLOW
    printf '\n  '
    set_color normal
end

# ===============================================
# Segment

function _segment
    set --local command_name $argv[1]
    set --local background_color $argv[2]
    set --local text_color $argv[3]
    set --local position $argv[4]

    # Round left-most segment
    set_color --background $background_color $text_color
    if [ $position = 'left' ]
        set_color --background normal $background_color
        printf $left_half_circle
    else
        echo -n ' '
    end

    # Show segment body
    set_color --background $background_color $text_color
    echo -n ($command_name)

    # Round right-most segment
    if [ $position = 'right' ]
        set_color --background normal $background_color
        printf $right_half_circle
    else
        echo -n ' '
    end

    set_color normal
end

# ===============================================
# directory

function _prompt_directory
    _segment _prompt_directory_body $color_dark $color_light 'left'
end


function _prompt_directory_body
  # prompt_pwd
  echo -n "🚀"
end

# ===============================================
# username

function _prompt_username
    if [ $last_status -eq 0 ]
        set color_username $color_main
    else
        set color_username $color_warning
    end

    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
      _segment _prompt_username_body $color_username $color_light 'internal'
    else
      _segment _prompt_username_body $color_username $color_light 'right'
    end
end


function _prompt_username_body
    # set --local host (hostname)
    # set --local host (command hostname 2> /dev/null | sed -e 's|\.local$||')
    echo -n  (whoami)@$(prompt_hostname)

end

# ===============================================
# git

function _prompt_git
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        if [ (_is_git_dirty) ]
            set color_git_status_bar $color_git_dirty
        else
            set color_git_status_bar $color_git_main
        end

        _segment _prompt_git_body $color_git_status_bar $color_dark 'right'
    end
end

# Check if the current git branch is changed
function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _prompt_git_body
    set --local git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    echo -n $git_branch
end

# ===============================================
# aws profile

function _prompt_aws_profile
    _segment _prompt_aws_profile_body $color_lightdark $color_light 'internal'
end

function _prompt_aws_profile_body
    echo "󰸏  $AWS_PROFILE"
end
