##### Homebrew の環境変数を有効化 (Mac用) #####
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

##### Language/Editor #####
#export LANG=en_US.UTF-8
#export EDITOR=nvim

#### starship ####
eval "$(starship init zsh)"

#### autosuggestions ####
# パスが存在する場合のみ読み込む（エラー防止）
if [ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

#### fast syntax highlighting ####
if [ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

#### fzf ####
if [ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]; then
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
fi
if [ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]; then
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi
export FZF_DEFAULT_OPTS="--height 40% --reverse --multi --preview 'cat {}' --preview-window right:30% --bind 'shift-up:preview-up,shift-down:preview-down'"

#### fzf functions ####
fvim() {
  local file
  file=$(fzf --preview 'cat {}')
  [ -n "$file" ] && vim "$file"
}

fcat() {
  fzf --preview 'cat {}' | xargs cat
}

nglow() {
  nb show "${1:-1}" | glow
}

#### zoxide ####
eval "$(zoxide init zsh)"
alias cd='z'
alias cdi='zi'

#### History search with arrow keys #####
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

#### Make word deletion stop at path separators, etc. ####
WORDCHARS=''

##### Aliases #####
alias ll='ls -la'
alias l='ls -l'

#### Apply hidden sources (ignored by Git; e.g., secrets or machine-specific) ####
# $HOME/.config/zsh/hidden がシンボリックリンク経由でも正しく読めるように設定
HIDDEN_ALIASES_DIR="$HOME/.config/zsh/hidden"
if [ -d "$HIDDEN_ALIASES_DIR" ]; then
  for f in "$HIDDEN_ALIASES_DIR"/*.zsh(N); do
    if [ -r "$f" ] && [ -f "$f" ]; then
      source "$f"
    fi
  done
fi

