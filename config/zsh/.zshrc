# ===============================================
# logger
# -----------------------------------------------
function logger_info {
  # green
  printf "\033[0;32;m[info ] %s\033[m\n" $1
}

function logger_warn {
  # yellow
  printf "\033[33m[warn ] %s\033[m\n" $1
}

function logger_error {
  # bold red
  printf "\033[1;31;m[error] %s\033[m\n" $1
}

function init {
}


# ===============================================
# homebrew
# -----------------------------------------------
function init_homebrew {
  brew_root='/opt/homebrew'

  # check if homebrew is installed
  if [ ! -d $brew_root ]; then
    logger_warn "homebrew is not installed. if you need to install homebrew, please vitist the website 'https://brew.sh'."
    return
  fi

  # initialize homebrew
  eval "$($brew_root/bin/brew shellenv)"

  # check if the initialization is successful
  if command -v brew 1> /dev/null 2>&1; then
    logger_info "successfully set up homebrew!"
  else
    logger_error "failed to initialize homebrew. check \`\$home/.zshrc\`."
  fi
}


# ===============================================
# handler
# -----------------------------------------------
function handler {
  init
  init_homebrew
}
handler
exec fish
