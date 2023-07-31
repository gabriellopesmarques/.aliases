#!/usr/bin/env bash

# install dependencies
sudo apt update && \
sudo apt install build-essential fzf ripgrep git wget curl tar gzip unzip -y

## download source and compile
if ! command -v nvim &> /dev/null; then
    mkdir ~/.src && cd ~/.src
    git clone --branch stable https://github.com/neovim/neovim

    # unzip is a dependency
    sudo apt install cmake gettext -y

    cd ~/.src/neovim
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

