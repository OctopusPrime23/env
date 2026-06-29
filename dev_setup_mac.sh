cd ~

brew install wget

wget https://github.com/sxyazi/yazi/releases/download/v26.5.6/yazi-aarch64-apple-darwin.zip
unzip yazi-aarch64-apple-darwin.zip

curl -sS https://starship.rs/install.sh | sh
starship preset catppuccin-powerline -o ~/.config/starship.toml

wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-macos-arm64.tar.gz
xattr -c ./nvim-macos-arm64.tar.gz && tar xzvf nvim-macos-arm64.tar.gz && rm nvim-macos-arm64.tar.gz

git clone https://github.com/NvChad/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git/

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
mkdir jetbrainsmono && unzip JetBrainsMono.zip -d jetbrainsmono
# apply nerd-fonts on system and change the font in the terminal
# then delete zip

wget https://github.com/syncthing/syncthing-macos/releases/download/v1.27.12-1/Syncthing-1.27.12-1.dmg
hdiutil attach Syncthing-1.27.12-1.dmg

brew install ripgrep jq tmux zoxide docker dust htop libxml2 mysql lazygit lazydocker nushell dlv ansible yq stow ffmpeg mkvtoolnix mediainfo imagemagick ghostscript fzf jupyterlab libpq trash-cli python@3.14 ffmpeg

echo 'export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"\nexport LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"\nexport CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"' >> ~/.zshrc

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22

# install go, python
source ~/.zshrc
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install -v github.com/incu6us/goimports-reviser/v3@latest
# install docker desktop

cat "0 12 * * 0 find $HOME/.local/share/nvim/backups/ -type f -mtime +30 -exec rm -f {} \;" >> /tmp/cron
crontab /tmp/cron

# curl --proto '=https' --tlsv1.2  https://sh.rustup.rs -sSf | sh
xcode-select --install
