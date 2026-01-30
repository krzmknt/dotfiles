#!/bin/bash
# macOS-specific setup

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

setup_macos() {
  if [[ "$OS" != "macos" ]]; then
    echo "Skipping macOS setup (not on macOS)."
    return 0
  fi

  echo "Setting up macOS-specific tools..."

  # Install macOS-specific brew packages and casks
  if [[ -f "$DOTFILES_DIR/packages/Brewfile.mac" ]]; then
    echo "Installing macOS packages from Brewfile.mac..."
    brew bundle --file="$DOTFILES_DIR/packages/Brewfile.mac"
  fi

  echo "macOS setup complete."
}

setup_macos
