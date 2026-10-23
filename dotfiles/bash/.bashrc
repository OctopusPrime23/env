export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

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
export PATH=$PATH:$(go env GOPATH)/bin
eval "$(zoxide init bash)"

set -o vi
bind -m vi-insert '"\C-r": history-search-backward'
bind -m vi-insert '"\C-s": history-search-forward'
bind -m vi-insert '"\C-a": beginning-of-line'
bind -m vi-insert '"\C-e": end-of-line'

alias yz=~/yazi-aarch64-apple-darwin/yazi
eval "$(starship init bash)"
