# bin/

Shell-agnostic utility scripts.

## Design Philosophy

1. **Shell-agnostic**: Works with zsh, fish, and bash
2. **Single responsibility**: One script = one function
3. **POSIX-compatible**: Written in bash for portability
4. **Self-contained**: Minimal external dependencies

## PATH Setup

The `install` script automatically adds this directory to PATH.

To add manually:

```bash
# zsh
export PATH=~/ghq/github.com/krzmknt/dotfiles/bin:$PATH

# fish
fish_add_path ~/ghq/github.com/krzmknt/dotfiles/bin
```

## Commands

| Command  | Description                     |
| -------- | ------------------------------- |
| `config` | Open dotfiles config and reload |

## Examples

```bash
config nvim      # Open nvim config
config zsh       # Open zsh config
config karabiner # Open karabiner config
```
