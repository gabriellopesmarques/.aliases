export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="x"

# vim mode
bindkey -v

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    vi-mode
)

# imports
source $ZSH/oh-my-zsh.sh
source ~/.aliases/aliases.sh

# nvm config 
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

