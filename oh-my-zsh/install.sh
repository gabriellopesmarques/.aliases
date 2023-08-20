#!/bin/bash

## install zsh
sudo apt install git curl zsh -y

## install oh my zsh (batch-mode)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## install autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## in this way, each user can get your own aliases too. edit file with: zc
echo "source ~/.aliases/oh-my-zsh/.zshrc" > $HOME/.zshrc

## custom theme
ln -s $HOME/.aliases/oh-my-zsh/themes/x.zsh-theme $HOME/.oh-my-zsh/custom/themes/x.zsh-theme

## set zsh as default shell
sudo chsh $USER --shell $(which zsh)

