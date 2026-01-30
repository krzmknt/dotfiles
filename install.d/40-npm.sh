#!/bin/bash
# npm global packages installation

set -e

install_npm_packages() {
  echo "Installing npm packages..."

  # Check if node is available (should be installed via mise)
  if ! command -v node &>/dev/null; then
    echo "Warning: Node.js not found. Skipping npm packages."
    echo "Please ensure Node.js is configured in mise."
    return 0
  fi

  # Install global packages
  npm install -g prettier

  echo "npm packages installed."
}

install_npm_packages
