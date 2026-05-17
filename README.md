# dotfiles

My personal dotfiles.

## Tools

| Tool | Purpose |
|------|---------|
| [Ghostty](https://ghostty.org) | Terminal emulator |
| [Zsh](https://www.zsh.org) | Shell |
| [Starship](https://starship.rs) | Prompt |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax highlighting |

## Setup

```sh
git clone https://github.com/dicek9t6/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

`make install` does the following:

1. Install Homebrew (if not already installed)
2. Install required packages
3. Create symlinks for each config file

### Install individually

```sh
make zsh       # ~/.zshrc
make ghostty   # ~/.config/ghostty/config
make starship  # ~/.config/starship.toml
```

## Structure

```
dotfiles/
├── .config/
│   ├── zsh/
│   │   └── .zshrc          # Zsh config and aliases
│   ├── ghostty/
│   │   └── config          # Ghostty appearance and keybindings
│   └── starship.toml       # Starship prompt theme (gruvbox dark)
├── Makefile
└── README.md
```

## Aliases

Aliases defined in `.zshrc`:

| Alias | Command |
|-------|---------|
| `ll` | `ls -la` |
| `l` | `ls -l` |

### Machine-specific aliases

Any `*.zsh` files placed in `~/.config/zsh/hidden/` are automatically sourced (excluded from Git).
Use this for secrets or machine-specific config.

```sh
# e.g. ~/.config/zsh/hidden/work.zsh
export API_KEY="..."
alias vpn="..."
```
