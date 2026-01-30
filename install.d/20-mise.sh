#!/bin/bash
# mise (language runtime manager) installation

set -e

install_mise() {
  echo "Installing mise..."

  if ! command -v mise &>/dev/null; then
    curl https://mise.run | sh

    # Add to PATH for current session
    export PATH="$HOME/.local/bin:$PATH"
  else
    echo "mise is already installed."
  fi

  # Trust the config directory
  mise trust ~/.config/mise/config.toml 2>/dev/null || true

  # Install configured runtimes
  if [[ -f ~/.config/mise/config.toml ]]; then
    echo "Installing runtimes from mise config..."
    mise install
  fi

  echo "mise setup complete."
}

install_mise
