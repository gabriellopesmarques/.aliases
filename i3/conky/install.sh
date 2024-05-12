#!/bin/bash

# install conky
sudo apt install conky-all

# create conky config directory
mkdir -p ~/.config/conky/

# link conky configs
ln -s ~/.aliases/i3/conky/conkyrc  ~/.config/conky/conky.conf

echo "exec --no-startup-id conky" >> ~/.config/i3/config

