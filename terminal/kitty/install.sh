#!/bin/env bash

kitty_conf=$HOME/.config/kitty/kitty.conf

# install kitty
sudo apt install kitty -y

# create kitt config directory
mkdir -p $(dirname $kitty_conf)

rm -f $kitty_conf

# link kitty config (default theme: deep_blue)
ln -s $HOME/.aliases/terminal/kitty/deep_blue.conf $kitty_conf

