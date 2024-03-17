# -----------------------------------------------
# Prompt
# -----------------------------------------------
set last_status
set total_segment_length

function fish_prompt
    set last_status $status
    set total_segment_length 0

    # left_top
    set_color $color_dark
    printf '\n╭─'
    set_color normal

    _prompt_directory
    _prompt_username
    _prompt_git

  # set_color $color_dark
  # set --local time_segment_length 12
  # string repeat -Nm(math $COLUMNS - $total_segment_length - $time_segment_length) '─'
  # set_color normal

  # _prompt_time

    # left_bottom
    set_color $color_dark
    printf '\n╰─ '
    set_color normal
end


function fish_right_prompt
    ;
end




# -----------------------------------------------
# segment
# -----------------------------------------------
function _segment
    set --local command_name $argv[1]
    set --local background_color $argv[2]
    set --local text_color $argv[3]
    set_color --background $background_color $text_color

    set --local body ' '($command_name)' '
    echo -n $body
    set total_segment_length (math $total_segment_length + (string length $body))

    set_color normal
end




# -----------------------------------------------
# directory
# -----------------------------------------------
function _prompt_directory
    _segment _prompt_directory_body $color_dark $color_light
end


function _prompt_directory_body
    prompt_pwd
end




# -----------------------------------------------
# username
# -----------------------------------------------
function _prompt_username
    if [ $last_status -eq 0 ]
        set color_username $color_main
    else
        set color_username $color_warning
    end
    _segment _prompt_username_body $color_username $color_light
end


function _prompt_username_body
    # set --local host (hostname)
    # set --local host (command hostname 2> /dev/null | sed -e 's|\.local$||')
    echo -n (whoami)@$(prompt_hostname)
end




# -----------------------------------------------
# date
# -----------------------------------------------
function _prompt_time
    _segment _prompt_time_body $color_dark $color_light
end


function _prompt_time_body
    date +"%H:%M:%S"
end




# -----------------------------------------------
# git
# -----------------------------------------------
function _prompt_git
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        if [ (_is_git_dirty) ]
            set color_git_status_bar $color_git_dirty
        else
            set color_git_status_bar $color_git_main
        end

        _segment _prompt_git_body $color_git_status_bar $color_dark
    end
end


function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end


function _prompt_git_body
    set --local git_branch (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
    echo -n $git_branch
end

