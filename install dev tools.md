
wget nvim appimage
chmod u+x nvim.appimage
Echo alias vim="./nvim.appimage" >> .bashrc

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

:MasonInstallAll

Packages -
Homebrew
warp
Docker desktop

