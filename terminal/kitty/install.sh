#!/bin/env bash

# install kitty
sudo apt-get install kitty

# create kitt config directory
mkdir -p ~/.config/kitty

# link kitty config (default theme: deep-blue)
ln -s ~/.aliases/terminal/deep-blue.conf ~/.config/kitty/kitty.conf

