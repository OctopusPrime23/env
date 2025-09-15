export PATH="/opt/homebrew/bin:$PATH"
export PATH="~/nvim-macos-arm64/bin:$PATH"

alias vim=~/nvim-macos-arm64/bin/nvim
alias nvim=~/nvim-macos-arm64/bin/nvim
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/go/bin:$PATH"
eval "$(zoxide init zsh)"
export PATH=$PATH:$(go env GOPATH)/bin
export MANPAGER='nvim +Man!'

alias ld=lazydocker
alias lg=lazygit
source ~/.zshrc.work
