# Change to home directory
cd ~

# Install wget using apt (Ubuntu's package manager)
sudo apt update
sudo apt install -y wget

wget https://github.com/sxyazi/yazi/releases/download/v26.5.6/yazi-aarch64-apple-darwin.zip
unzip yazi-aarch64-apple-darwin.zip
echo 'alias yz=~/yazi-aarch64-apple-darwin/yazi' >> ~/.zshrc
echo 'alias yz=~/yazi-aarch64-apple-darwin/yazi' >> ~/.bashrc

curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Download and extract Neovim
wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

# Create an alias for vim
echo 'alias nvim=~/nvim-linux-x86_64.appimage' >> ~/.zshrc
echo 'alias nvim=~/nvim-linux-x86_64.appimage' >> ~/.bashrc

wget https://github.com/nushell/nushell/releases/download/0.113.1/nu-0.113.1-x86_64-unknown-linux-gnu.tar.gz
tar xzvf nu-0.113.1-x86_64-unknown-linux-gnu.tar.gz && rm nu-0.113.1-x86_64-unknown-linux-gnu.tar.gz
echo 'alias nu=~/nu-0.113.1-x86_64-unknown-linux-gnu/nu' >> ~/.zshrc
echo 'alias nu=~/nu-0.113.1-x86_64-unknown-linux-gnu/nu' >> ~/.bashrc

# Clone NvChad starter repository
git clone https://github.com/NvChad/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git/

# Download and unzip Nerd Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
mkdir jetbrainsmono && unzip JetBrainsMono.zip -d jetbrainsmono
# apply nerd-fonts
# then delete zip

# Install necessary packages
sudo apt install -y ripgrep jq tmux zoxide htop libxml2
sudo snap install lazygit

# Update PATH and other environment variables
echo 'export PATH="/usr/include/libxml2:$PATH"' >> ~/.zshrc

# Initialize zoxide
eval "$(zoxide init zsh)"
eval "$(zoxide init bash)"
echo 'alias z=zoxide' >> ~/.bashrc
echo 'alias z=zoxide' >> ~/.zshrc

# From local machine
# scp -r ~/.config/nvim/lua/* <host>:~/.config/nvim/lua/

echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.zshrc
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.zshrc && source ~/.zshrc
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
go install -v github.com/incu6us/goimports-reviser/v3@latest
source ~/.zshrc
source ~/.bashrc

# making the server understand ghostty's capabilities
infocmp -x xterm-ghostty | ssh SERVER -- tic -x -
