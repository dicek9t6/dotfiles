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
| [Karabiner-Elements](https://karabiner-elements.pqrs.org) | Key remapping (MacBook Air US layout) |

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
make karabiner # ~/.config/karabiner/karabiner.json (MacBook Air US layout only)
```

## Structure

```
dotfiles/
├── .config/
│   ├── zsh/
│   │   └── .zshrc          # Zsh config and aliases
│   ├── ghostty/
│   │   └── config          # Ghostty appearance and keybindings
│   ├── karabiner/
│   │   └── karabiner.json  # Key remapping for MacBook Air US layout
│   └── starship.toml       # Starship prompt theme (gruvbox dark)
├── Makefile
└── README.md
```

## Ghostty Keybindings

### Pane

| Key | Action |
|-----|--------|
| `Ctrl+Shift+V` | Split right |
| `Ctrl+Shift+H` | Split down |
| `Ctrl+H/J/K/L` | Navigate pane left/down/up/right |
| `Ctrl+,` / `Ctrl+.` | Resize pane left/right |
| `Ctrl+;` / `Ctrl+'` | Resize pane down/up |
| `Ctrl+X` | Close pane |

### Scroll

| Key | Action |
|-----|--------|
| `Ctrl+Shift+K` | Scroll up 3 lines |
| `Ctrl+Shift+J` | Scroll down 3 lines |

### Editing

| Key | Action |
|-----|--------|
| `Shift+Enter` | Insert newline without submitting |
| `Alt+Backspace` / `Shift+Backspace` | Delete word |

## Karabiner (MacBook Air US layout)

### Key Remapping

```
┌──────────┬──────────┬──────────┬──────────┐
│ Caps Lock│  Ctrl    │  Option  │ Command  │
│    ↓     │    ↓     │    ↓     │    ↓     │
│  Ctrl    │  Option  │ Command  │   Fn     │
└──────────┴──────────┴──────────┴──────────┘
```

### Fn Layer

```
┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
│  Q  │  W  │  E  │  R  │  T  │   │  Y  │  U  │  I  │  O  │  P  │
│     │     │  ↑  │     │     │   │     │PgUp │  ↑  │PgDn │     │
├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
│  A  │  S  │  D  │  F  │  G  │   │  H  │  J  │  K  │  L  │  ;  │
│Home │  ←  │  ↓  │  →  │ End │   │ BS  │  ←  │  ↓  │  →  │ Del │
├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
│  Z  │  X  │  C  │  V  │  B  │   │  N  │  M  │  ,  │  .  │     │
│     │     │     │     │     │   │     │Mute │Vol- │Vol+ │     │
└─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
                    ┌─────────────────┐
                    │      Space      │
                    │      Enter      │
                    └─────────────────┘
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
