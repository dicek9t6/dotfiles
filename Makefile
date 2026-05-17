DOTFILES := $(shell pwd)
HOMEBREW_PACKAGES := starship zsh-autosuggestions zsh-syntax-highlighting

.PHONY: install zsh ghostty starship brew karabiner

install: brew zsh ghostty starship

brew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "==> Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
	@if [ -f "/opt/homebrew/bin/brew" ]; then eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi
	@echo "==> Installing packages..."
	brew install $(HOMEBREW_PACKAGES)

zsh:
	@echo "==> Linking zsh config..."
	@$(MAKE) _symlink SRC=$(DOTFILES)/.config/zsh/.zshrc DST=$(HOME)/.zshrc

ghostty:
	@echo "==> Linking Ghostty config..."
	@mkdir -p $(HOME)/.config/ghostty
	@$(MAKE) _symlink SRC=$(DOTFILES)/.config/ghostty/config DST=$(HOME)/.config/ghostty/config

starship:
	@echo "==> Linking Starship config..."
	@mkdir -p $(HOME)/.config
	@$(MAKE) _symlink SRC=$(DOTFILES)/.config/starship.toml DST=$(HOME)/.config/starship.toml

# MacBook Air (US layout) only — not included in install
karabiner:
	@echo "==> Linking Karabiner config (MacBook Air US layout)..."
	@mkdir -p $(HOME)/.config/karabiner
	@$(MAKE) _symlink SRC=$(DOTFILES)/.config/karabiner/karabiner.json DST=$(HOME)/.config/karabiner/karabiner.json

_symlink:
	@if [ -e "$(DST)" ] && [ ! -L "$(DST)" ]; then \
		echo "    Backing up $(DST) -> $(DST).bak"; \
		mv "$(DST)" "$(DST).bak"; \
	fi
	@ln -sf "$(SRC)" "$(DST)"
	@echo "    $(DST) -> $(SRC)"
