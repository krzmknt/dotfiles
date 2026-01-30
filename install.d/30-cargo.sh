#!/bin/bash
# Rust and cargo packages installation

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

install_rust() {
  if ! command -v cargo &>/dev/null; then
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  else
    echo "Rust is already installed."
  fi
}

install_cargo_packages() {
  echo "Installing cargo packages..."

  local packages_file="$DOTFILES_DIR/packages/cargo-packages.txt"

  if [[ -f "$packages_file" ]]; then
    while IFS= read -r package || [[ -n "$package" ]]; do
      # Skip empty lines and comments
      [[ -z "$package" || "$package" =~ ^# ]] && continue

      echo "Installing $package..."
      cargo install "$package" || echo "Warning: Failed to install $package"
    done < "$packages_file"
  else
    # Default packages if no file exists
    cargo install bat eza fd-find ripgrep
  fi

  echo "Cargo packages installed."
}

install_rust
install_cargo_packages
