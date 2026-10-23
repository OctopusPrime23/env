#!/usr/bin/env bash
# Idempotent setup for the Linux (x86_64) work VM: every step checks whether it's already done and skips if so.
# Lighter than dev_setup_mac.sh: only the dev tools needed for work, no personal apps or identities.
# The mac rc files hardcode Homebrew/macOS paths, so shell config is appended here instead of stowed.
set -u

DOTFILES="$(cd "$(dirname "$0")" && pwd)/dotfiles"
# Only these dotfiles packages are stowed on the VM
STOW_PACKAGES=(nvim)

cd ~

skip() { echo "✓ $1 already installed, skipping"; }

# Append a line to a file unless it's already there
add_line() { grep -qxF -- "$2" "$1" 2>/dev/null || echo "$2" >> "$1"; }
add_rc() { add_line ~/.zshrc "$1"; add_line ~/.bashrc "$1"; }

# Apt packages
APT_PACKAGES=(wget unzip git stow ripgrep jq tmux zoxide htop libxml2 build-essential)
missing=()
for pkg in "${APT_PACKAGES[@]}"; do
  dpkg -s "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done
if [ ${#missing[@]} -eq 0 ]; then skip "all apt packages"; else sudo apt update && sudo apt install -y "${missing[@]}"; fi

# Lazygit
if command -v lazygit >/dev/null 2>&1; then skip "lazygit"; else sudo snap install lazygit; fi

# Dotfiles
for pkg in "${STOW_PACKAGES[@]}"; do
  stow -d "$DOTFILES" -t ~ "$pkg" || echo "✗ couldn't stow $pkg (existing files in the way?), skipping"
done

# Yazi
if [ -x ~/yazi-x86_64-unknown-linux-gnu/yazi ]; then
  skip "yazi"
else
  wget https://github.com/sxyazi/yazi/releases/download/v26.5.6/yazi-x86_64-unknown-linux-gnu.zip
  unzip yazi-x86_64-unknown-linux-gnu.zip && rm yazi-x86_64-unknown-linux-gnu.zip
fi

# Starship
if command -v starship >/dev/null 2>&1; then skip "starship"; else curl -sS https://starship.rs/install.sh | sh; fi
[ -f ~/.config/starship.toml ] || starship preset catppuccin-powerline -o ~/.config/starship.toml

# Neovim
NVIM_VERSION=v0.12.5
if [ -x ~/nvim-linux-x86_64/bin/nvim ] && [ "$(~/nvim-linux-x86_64/bin/nvim --version | head -1)" = "NVIM $NVIM_VERSION" ]; then
  skip "neovim $NVIM_VERSION"
else
  wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz
  rm -rf ~/nvim-linux-x86_64
  tar xzf nvim-linux-x86_64.tar.gz && rm nvim-linux-x86_64.tar.gz
fi

# tree-sitter CLI, needed by nvim-treesitter (main) to build parsers
TREE_SITTER_VERSION=v0.27.1
if command -v tree-sitter >/dev/null 2>&1 && [ "$(tree-sitter --version | cut -d' ' -f2)" = "${TREE_SITTER_VERSION#v}" ]; then
  skip "tree-sitter $TREE_SITTER_VERSION"
else
  wget https://github.com/tree-sitter/tree-sitter/releases/download/$TREE_SITTER_VERSION/tree-sitter-linux-x64.gz
  gunzip tree-sitter-linux-x64.gz && sudo install -m 755 tree-sitter-linux-x64 /usr/local/bin/tree-sitter && rm tree-sitter-linux-x64
fi

# Nushell
NU_VERSION=0.113.1
if [ -x ~/nu-$NU_VERSION-x86_64-unknown-linux-gnu/nu ]; then
  skip "nushell $NU_VERSION"
else
  wget https://github.com/nushell/nushell/releases/download/$NU_VERSION/nu-$NU_VERSION-x86_64-unknown-linux-gnu.tar.gz
  tar xzf nu-$NU_VERSION-x86_64-unknown-linux-gnu.tar.gz && rm nu-$NU_VERSION-x86_64-unknown-linux-gnu.tar.gz
fi

# Nerd fonts
if [ -d ~/jetbrainsmono ]; then
  skip "JetBrainsMono nerd font"
else
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  mkdir jetbrainsmono && unzip JetBrainsMono.zip -d jetbrainsmono
  # apply nerd-fonts
  # then delete zip
fi

# Go tools (Go itself is expected in /usr/local/go)
export PATH="/usr/local/go/bin:$PATH"
if command -v go >/dev/null 2>&1; then
  GOBIN_DIR="$(go env GOPATH)/bin"
  [ -x "$GOBIN_DIR/goimports" ] && skip "goimports" || go install golang.org/x/tools/cmd/goimports@latest
  [ -x "$GOBIN_DIR/golines" ] && skip "golines" || go install github.com/segmentio/golines@latest
  [ -x "$GOBIN_DIR/goimports-reviser" ] && skip "goimports-reviser" || go install -v github.com/incu6us/goimports-reviser/v3@latest
else
  echo "✗ go not found, skipping go tools"
fi

# Shell config
add_line ~/.zshrc 'bindkey -v'
# Also enable emacs style searches
add_line ~/.zshrc "bindkey '^R' history-incremental-search-backward"
add_line ~/.zshrc "bindkey '^S' history-incremental-search-forward"  # Ctrl+S for forward search
add_line ~/.zshrc "bindkey '^A' beginning-of-line"
add_line ~/.zshrc "bindkey '^E' end-of-line"

add_line ~/.bashrc 'set -o vi'
# Also enable emacs style searches
add_line ~/.bashrc "bind -m vi-insert '\"\\C-r\": history-search-backward'"
add_line ~/.bashrc "bind -m vi-insert '\"\\C-s\": history-search-forward'"  # Ctrl+S for forward search
add_line ~/.bashrc "bind -m vi-insert '\"\\C-a\": beginning-of-line'"
add_line ~/.bashrc "bind -m vi-insert '\"\\C-e\": end-of-line'"

add_line ~/.inputrc 'set editing-mode vi'

add_rc 'export PATH="$HOME/nvim-linux-x86_64/bin:$PATH"'
add_rc 'alias vim=~/nvim-linux-x86_64/bin/nvim'
add_rc 'alias nvim=~/nvim-linux-x86_64/bin/nvim'
add_rc 'export PSQL_EDITOR=~/nvim-linux-x86_64/bin/nvim'
add_rc 'export EDITOR=~/nvim-linux-x86_64/bin/nvim'
add_rc "export MANPAGER='nvim +Man!'"

add_rc 'alias yz=~/yazi-x86_64-unknown-linux-gnu/yazi'
add_rc "alias nu=~/nu-$NU_VERSION-x86_64-unknown-linux-gnu/nu"
add_rc 'alias lg=lazygit'

add_rc 'export PATH="/usr/include/libxml2:$PATH"'
add_rc 'export PATH="/usr/local/go/bin:$PATH"'
add_rc 'export PATH=$PATH:$(go env GOPATH)/bin'

add_line ~/.zshrc 'eval "$(zoxide init zsh)"'
add_line ~/.bashrc 'eval "$(zoxide init bash)"'
add_rc 'alias z=zoxide'

add_line ~/.zshrc 'eval "$(starship init zsh)"'
add_line ~/.bashrc 'eval "$(starship init bash)"'

# Make this VM understand ghostty's capabilities (run from the local machine):
# infocmp -x xterm-ghostty | ssh SERVER -- tic -x -

echo "Done. Open a new shell."
