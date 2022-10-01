#!/bin/bash

sudo apt-get install neofetch -y

mkdir -p ~/.config/neofetch
ln -s ~/.aliases/neofetch/config.conf ~/.config/neofetch/config.conf

