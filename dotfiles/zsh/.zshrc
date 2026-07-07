export PATH="/opt/homebrew/bin:$PATH"
export PATH="~/nvim-macos-arm64/bin:$PATH"

alias vim=~/nvim-macos-arm64/bin/nvim
alias nvim=~/nvim-macos-arm64/bin/nvim
export PSQL_EDITOR=~/nvim-macos-arm64/bin/nvim
export EDITOR=~/nvim-macos-arm64/bin/nvim

export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/usr/local/go/bin:$PATH"
eval "$(zoxide init zsh)"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:/usr/local/go/bin
export MANPAGER='nvim +Man!'

alias ld=lazydocker
alias lg=lazygit
source ~/.zshrc.work

export COMPOSE_BAKE=true
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

alias yz=~/yazi-aarch64-apple-darwin/yazi
eval "$(starship init zsh)"

function chpwd {
  ls -a --color
}
