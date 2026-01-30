#!/bin/bash
# System packages installation

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install_system_packages() {
  echo "Installing system packages for $OS..."

  case "$OS" in
    macos)
      # Install Homebrew if not present
      if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Configure environment
        if [[ $(uname -m) == "arm64" ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
        else
          eval "$(/usr/local/bin/brew shellenv)"
        fi
      fi

      # Install system packages via brew
      brew install git curl stow tmux neovim jq gh ghq fzf wget tree gpg coreutils
      ;;

    ubuntu)
      sudo apt update
      sudo apt install -y \
        git curl stow tmux neovim jq gh fzf wget tree gnupg \
        build-essential pkg-config libssl-dev
      ;;

    al2023)
      sudo dnf install -y \
        git curl stow tmux neovim jq gh fzf wget tree gnupg2 \
        gcc pkg-config openssl-devel
      ;;

    fedora)
      sudo dnf install -y \
        git curl stow tmux neovim jq gh fzf wget tree gnupg2 \
        gcc pkg-config openssl-devel
      ;;

    *)
      echo "Warning: Unknown OS '$OS'. Skipping system package installation."
      ;;
  esac

  echo "System packages installed."
}

install_system_packages
