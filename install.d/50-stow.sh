#!/bin/bash
# Dotfiles symlinking with stow

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

link_config() {
  local source_dir="$1"
  local name="$2"

  if [[ ! -d "$source_dir/$name" ]]; then
    echo "Warning: $source_dir/$name not found. Skipping."
    return 0
  fi

  echo "Linking $name..."
  stow -v -d "$source_dir" -t ~ "$name"
}

link_configs() {
  echo "Linking dotfiles..."

  # Common configs (all platforms)
  if [[ -d "$CONFIG_DIR/common" ]]; then
    for dir in "$CONFIG_DIR/common"/*/; do
      name=$(basename "$dir")
      link_config "$CONFIG_DIR/common" "$name"
    done
  fi

  # macOS-specific configs
  if [[ "$OS" == "macos" && -d "$CONFIG_DIR/macos" ]]; then
    for dir in "$CONFIG_DIR/macos"/*/; do
      name=$(basename "$dir")
      link_config "$CONFIG_DIR/macos" "$name"
    done
  fi

  # Add dotfiles/bin to PATH
  setup_bin_path

  echo "Dotfiles linked."
}

setup_bin_path() {
  local DOTFILES_BIN="$DOTFILES_DIR/bin"

  # Add to .zshrc if not already present
  if [[ -f ~/.zshrc ]] && ! grep -q "dotfiles/bin" ~/.zshrc 2>/dev/null; then
    echo "" >> ~/.zshrc
    echo "# dotfiles bin" >> ~/.zshrc
    echo "export PATH=\"$DOTFILES_BIN:\$PATH\"" >> ~/.zshrc
  fi

  # Add to .bashrc if not already present
  if [[ -f ~/.bashrc ]] && ! grep -q "dotfiles/bin" ~/.bashrc 2>/dev/null; then
    echo "" >> ~/.bashrc
    echo "# dotfiles bin" >> ~/.bashrc
    echo "export PATH=\"$DOTFILES_BIN:\$PATH\"" >> ~/.bashrc
  fi
}

link_configs
