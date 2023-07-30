#!/usr/bin/env bash

if ! command -v nvim &> /dev/null; then
    echo "install nvim >8.0 first"
    exit 1
fi

# install dependencies
sudo apt update && \
sudo apt install build-essential git wget curl tar gzip unzip -y

## install nvm
if [[ ! -d "$HOME/.nvm" ]]; then
    git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
    bash $HOME/.nvm/install.sh
fi

## install node lts
source $HOME/.nvm/nvm.sh
nvm install --lts

# nvim config 
ln -s $HOME/.aliases/nvim/nvim $HOME/.config/nvim

