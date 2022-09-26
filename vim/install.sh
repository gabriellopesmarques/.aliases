#!/bin/bash

## install vim
sudo apt-get install git curl vim -y

## install plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## install nvm to . . .
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

## reload vars and install node lts
source ~/.zshrc && nvm install --lts

## load .aliases vim configs
echo "source ~/.aliases/vim/vimrc" >> ~/.vimrc

## run plug install quiet
vim +PlugInstall +qall

