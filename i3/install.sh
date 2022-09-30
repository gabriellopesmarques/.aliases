#!/bin/bash

# install i3 and utils
sudo apt-get install xorg i3 i3status feh gnome-terminal pulseaudio brightnessctl

# create i3 config directory
mkdir -p ~/.config/i3

# link config file
ln -s ~/.aliases/i3/i3.conf ~/.config/i3/config

# create i3status config directory
mkdir -p ~/.config/i3status

# link config file
ln -s ~/.aliases/i3/i3status.conf  ~/.config/i3status/config

# create dunst config directory
mkdir -p ~/.config/dunst/

# link config file
ln -s ~/.aliases/i3/dunstrc  ~/.config/dunst/dunstrc

