# dotfiles

Cross-platform dotfiles for macOS, Ubuntu, and Amazon Linux 2023.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/krzmknt/dotfiles/main/install | bash
```

Or clone and run manually:

```bash
git clone https://github.com/krzmknt/dotfiles ~/ghq/github.com/krzmknt/dotfiles
cd ~/ghq/github.com/krzmknt/dotfiles
./install
```

## Supported Platforms

| Platform          | Package Manager |
| ----------------- | --------------- |
| macOS             | Homebrew        |
| Ubuntu / Debian   | apt             |
| Amazon Linux 2023 | dnf             |
| Fedora / RHEL     | dnf             |

## What Gets Installed

### System Packages

Core tools installed via system package manager:

| Package | Description                     |
| ------- | ------------------------------- |
| git     | Version control                 |
| curl    | Data transfer                   |
| stow    | Symlink farm manager            |
| tmux    | Terminal multiplexer            |
| neovim  | Text editor                     |
| jq      | JSON processor                  |
| fzf     | Fuzzy finder                    |
| gh      | GitHub CLI                      |
| ghq     | Repository manager (macOS only) |
| wget    | File downloader                 |
| tree    | Directory listing               |
| gpg     | Encryption                      |

### Rust Tools (via cargo)

High-performance CLI tools:

| Package         | Command       | Description                  |
| --------------- | ------------- | ---------------------------- |
| bat             | `bat`         | cat with syntax highlighting |
| eza             | `eza`         | Modern ls replacement        |
| fd-find         | `fd`          | Fast file finder             |
| ripgrep         | `rg`          | Fast grep replacement        |
| tree-sitter-cli | `tree-sitter` | Parser generator             |

### Node.js Tools (via npm)

| Package  | Description    |
| -------- | -------------- |
| prettier | Code formatter |

### macOS Only

GUI applications (via Homebrew Cask):

| Application        | Description              |
| ------------------ | ------------------------ |
| WezTerm            | GPU-accelerated terminal |
| Karabiner-Elements | Keyboard customizer      |
| Raycast            | Launcher                 |
| Docker             | Container platform       |
| AppCleaner         | App uninstaller          |

macOS-specific tools:

| Tool  | Description           |
| ----- | --------------------- |
| yabai | Tiling window manager |
| skhd  | Hotkey daemon         |

## Directory Structure

```
dotfiles/
├── install              # Main installer script
├── install.d/           # Modular install scripts
│   ├── 00-detect-os.sh
│   ├── 10-system-packages.sh
│   ├── 20-mise.sh
│   ├── 30-cargo.sh
│   ├── 40-npm.sh
│   ├── 50-stow.sh
│   └── 90-macos.sh
├── packages/            # Package definitions
│   ├── apt-packages.txt
│   ├── dnf-packages.txt
│   ├── cargo-packages.txt
│   └── Brewfile.mac
├── config/
│   ├── common/          # Cross-platform configs
│   │   ├── nvim/
│   │   ├── tmux/
│   │   ├── zsh/
│   │   ├── mise/
│   │   ├── wezterm/
│   │   └── claude/
│   └── macos/           # macOS-specific configs
│       ├── karabiner/
│       ├── skhd/
│       └── yabai/
└── bin/                 # Custom scripts
```

## Configuration Details

### Neovim

- Location: `~/.config/nvim`

### tmux

- Location: `~/.tmux.conf`
- Custom scripts: `~/.tmux.bin/`

### Zsh

- Location: `~/.zshrc`

### mise (Runtime Manager)

- Location: `~/.config/mise/`
- Manages: Node.js, Python, Go, Rust, etc.

## Customization

### Adding Packages

Edit the appropriate file in `packages/`:

- `cargo-packages.txt` - Rust tools (all platforms)
- `apt-packages.txt` - Ubuntu/Debian
- `dnf-packages.txt` - AL2023/Fedora
- `Brewfile.mac` - macOS GUI apps

### Adding Configs

1. Create directory under `config/common/` or `config/macos/`
2. Mirror the target structure (e.g., `config/common/foo/.config/foo/`)
3. Run `stow -v -d config/common -t ~ foo`

## License

MIT
