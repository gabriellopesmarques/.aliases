#!/bin/bash

sudo apt install bat -y

mkdir -p $HOME/.config/bat/themes/

ln -s $HOME/.aliases/bat/TokyoNordStorm.tmTheme $HOME/.config/bat/themes/TokyoNordStorm.tmTheme

bat cache --build

