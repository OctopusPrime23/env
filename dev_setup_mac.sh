#!/usr/bin/env bash
# Idempotent macOS dev setup: every step checks whether it's already done and skips if so.
set -u

cd ~

# Append a line to a file only if that exact line isn't already present
append_once() {
  local file="$1" line="$2"
  touch "$file"
  grep -qxF -- "$line" "$file" || echo "$line" >> "$file"
}

skip() { echo "✓ $1 already installed, skipping"; }

# Xcode command line tools
if xcode-select -p >/dev/null 2>&1; then skip "xcode-select"; else xcode-select --install; fi

# Homebrew
if command -v brew >/dev/null 2>&1 || [ -x /opt/homebrew/bin/brew ]; then
  skip "homebrew"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# Claude Code
if command -v claude >/dev/null 2>&1 || [ -x ~/.local/bin/claude ]; then
  skip "claude"
else
  curl -fsSL https://claude.ai/install.sh | bash
fi
append_once ~/.zshrc 'export PATH="$HOME/.local/bin:$PATH"'
export PATH="$HOME/.local/bin:$PATH"

# Brew packages
BREW_PACKAGES=(
  wget ripgrep jq tmux zoxide docker dust htop libxml2 mysql lazygit lazydocker nushell dlv ansible yq stow
  ffmpeg mkvtoolnix mediainfo imagemagick ghostscript fzf jupyterlab libpq trash-cli python@3.14
)
missing=()
for pkg in "${BREW_PACKAGES[@]}"; do
  brew list --formula "$pkg" >/dev/null 2>&1 || missing+=("$pkg")
done
if [ ${#missing[@]} -eq 0 ]; then skip "all brew packages"; else brew install "${missing[@]}"; fi

append_once ~/.zshrc 'export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"'
append_once ~/.zshrc 'export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"'
append_once ~/.zshrc 'export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"'

# Yazi
if [ -x ~/yazi-aarch64-apple-darwin/yazi ]; then
  skip "yazi"
else
  wget https://github.com/sxyazi/yazi/releases/download/v26.5.6/yazi-aarch64-apple-darwin.zip
  unzip yazi-aarch64-apple-darwin.zip && rm yazi-aarch64-apple-darwin.zip
fi
append_once ~/.zshrc 'alias yz=~/yazi-aarch64-apple-darwin/yazi'
append_once ~/.bashrc 'alias yz=~/yazi-aarch64-apple-darwin/yazi'

# Starship
if command -v starship >/dev/null 2>&1; then skip "starship"; else curl -sS https://starship.rs/install.sh | sh; fi
[ -f ~/.config/starship.toml ] || starship preset catppuccin-powerline -o ~/.config/starship.toml
append_once ~/.zshrc 'eval "$(starship init zsh)"'
append_once ~/.bashrc 'eval "$(starship init bash)"'

# Neovim
if [ -x ~/nvim-macos-arm64/bin/nvim ]; then
  skip "neovim"
else
  wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz
  xattr -c ./nvim-macos-arm64.tar.gz && tar xzvf nvim-macos-arm64.tar.gz && rm nvim-macos-arm64.tar.gz
fi
for rc in ~/.zshrc ~/.bashrc; do
  append_once "$rc" 'alias vim=~/nvim-macos-arm64/bin/nvim'
  append_once "$rc" 'alias nvim=~/nvim-macos-arm64/bin/nvim'
  append_once "$rc" 'export PSQL_EDITOR=~/nvim-macos-arm64/bin/nvim'
  append_once "$rc" 'export EDITOR=~/nvim-macos-arm64/bin/nvim'
done

# Nerd fonts
if ls ~/Library/Fonts/JetBrainsMonoNerdFont* >/dev/null 2>&1 || [ -d ~/jetbrainsmono ]; then
  skip "JetBrainsMono nerd font"
else
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  mkdir jetbrainsmono && unzip JetBrainsMono.zip -d jetbrainsmono
  # apply nerd-fonts on system and change the font in the terminal
  # then delete zip
fi

# Syncthing
if [ -d /Applications/Syncthing.app ]; then
  skip "syncthing"
else
  wget https://github.com/syncthing/syncthing-macos/releases/download/v1.27.12-1/Syncthing-1.27.12-1.dmg
  hdiutil attach Syncthing-1.27.12-1.dmg
fi

# Shell keybindings: vi mode plus emacs-style search/navigation
append_once ~/.zshrc 'bindkey -v'
append_once ~/.zshrc "bindkey '^R' history-incremental-search-backward"
append_once ~/.zshrc "bindkey '^S' history-incremental-search-forward"
append_once ~/.zshrc "bindkey '^A' beginning-of-line"
append_once ~/.zshrc "bindkey '^E' end-of-line"

append_once ~/.bashrc 'set -o vi'
append_once ~/.bashrc "bind -m vi-insert '\"\\C-r\": history-search-backward'"
append_once ~/.bashrc "bind -m vi-insert '\"\\C-s\": history-search-forward'"
append_once ~/.bashrc "bind -m vi-insert '\"\\C-a\": beginning-of-line'"
append_once ~/.bashrc "bind -m vi-insert '\"\\C-e\": end-of-line'"

append_once ~/.inputrc 'set editing-mode vi'

# Zoxide
append_once ~/.zshrc 'eval "$(zoxide init zsh)"'
append_once ~/.bashrc 'eval "$(zoxide init bash)"'

# Node via nvm
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  skip "nvm"
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi
. "$NVM_DIR/nvm.sh"
NODE_LATEST="$(nvm version-remote node)"
if [ "$(nvm version node)" = "$NODE_LATEST" ]; then
  skip "node $NODE_LATEST"
else
  nvm install node
fi
nvm alias default node >/dev/null

# Go (latest official release into /usr/local/go, which is first on PATH)
GO_LATEST="$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -1)"
if [ -x /usr/local/go/bin/go ] && [ "$(/usr/local/go/bin/go env GOVERSION)" = "$GO_LATEST" ]; then
  skip "$GO_LATEST"
else
  curl -fsSLo "/tmp/$GO_LATEST.darwin-arm64.tar.gz" "https://go.dev/dl/$GO_LATEST.darwin-arm64.tar.gz"
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "/tmp/$GO_LATEST.darwin-arm64.tar.gz"
  rm "/tmp/$GO_LATEST.darwin-arm64.tar.gz"
fi
append_once ~/.zshrc 'export PATH="/usr/local/go/bin:$PATH"'
append_once ~/.bashrc 'export PATH="/usr/local/go/bin:$PATH"'
export PATH="/usr/local/go/bin:$PATH"

# Go tools
append_once ~/.zshrc 'export PATH=$PATH:$(go env GOPATH)/bin'
append_once ~/.bashrc 'export PATH=$PATH:$(go env GOPATH)/bin'
GOBIN_DIR="$(go env GOPATH)/bin"
[ -x "$GOBIN_DIR/goimports" ] && skip "goimports" || go install golang.org/x/tools/cmd/goimports@latest
[ -x "$GOBIN_DIR/golines" ] && skip "golines" || go install github.com/segmentio/golines@latest
[ -x "$GOBIN_DIR/goimports-reviser" ] && skip "goimports-reviser" || go install -v github.com/incu6us/goimports-reviser/v3@latest
# install docker desktop

# Weekly cleanup of old nvim backups
CRON_LINE="0 12 * * 0 find $HOME/.local/share/nvim/backups/ -type f -mtime +30 -exec rm -f {} \;"
if crontab -l 2>/dev/null | grep -qxF -- "$CRON_LINE"; then
  skip "nvim backup cleanup cron"
else
  (crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
fi

# curl --proto '=https' --tlsv1.2  https://sh.rustup.rs -sSf | sh

# Make remote servers understand ghostty's capabilities (run per server):
# infocmp -x xterm-ghostty | ssh SERVER -- tic -x -

echo "Done. Open a new shell (or 'source ~/.zshrc') to pick up changes."
