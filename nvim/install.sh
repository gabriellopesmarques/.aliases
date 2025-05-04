#!/usr/bin/env bash

# install dependencies
sudo apt update && \
sudo apt install build-essential fzf ripgrep git wget curl tar gzip unzip -y

## download source and compile
if ! command -v nvim &> /dev/null; then
    mkdir -p "$HOME/.src" && cd "$HOME/.src"
    git clone --branch stable https://github.com/neovim/neovim

    # unzip is a dependency
    sudo apt install cmake gettext -y

    cd "$HOME/.src/neovim"
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
fi

## install nvm
if [[ ! -d "$HOME/.nvm" ]]; then
    git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
    bash $HOME/.nvm/install.sh
fi

## install node lts
source $HOME/.nvm/nvm.sh
nvm install --lts

# to ensure .config directory exists
mkdir -p $HOME/.config/

# nvim config 
ln -s $HOME/.aliases/nvim/nvim $HOME/.config/nvim

# set up nvm to install plugins now
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# install plugins
nvim --headless "+Lazy! sync" +qa && \
nvim --headless -c 'MasonInstall clangd' -c "qall" && \
nvim --headless -c 'MasonInstall bash-language-server' -c "qall" && \
nvim --headless -c 'MasonInstall lua-language-server' -c "qall" && \
nvim --headless -c 'MasonInstall intelephense' -c "qall" && \
nvim --headless -c 'MasonInstall pyright' -c "qall" && \
nvim --headless -c 'MasonInstall dockerfile-language-server' -c "qall" && \
nvim --headless -c 'MasonInstall docker-compose-language-service' -c "qall"

