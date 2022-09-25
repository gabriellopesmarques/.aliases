#!/bin/bash

## install zsh
sudo apt-get install zsh -y

## install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## install autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## use .aliases config file
echo "source ~/.aliases/oh-my-zsh/.zshrc" > ~/.zshrc

## use .aliases theme file
echo "source ~/.aliases/oh-my-zsh/themes/x.zsh-theme" > ~/.oh-my-zsh/custom/themes/x.zsh-theme
