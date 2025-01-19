# Change to home directory
cd ~

# Install wget using apt (Ubuntu's package manager)
sudo apt update
sudo apt install -y wget

# Download and extract Neovim
wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz && rm nvim-linux64.tar.gz

# Create an alias for vim
echo 'alias nvim=~/nvim-linux64/bin/nvim' >> ~/.zshrc

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
