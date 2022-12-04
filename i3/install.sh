#!/bin/bash

# install i3 and utils
sudo apt-get install xorg i3 i3status feh gnome-terminal pulseaudio brightnessctl rofi

# create i3 config directory
mkdir -p ~/.config/i3

# link config file
ln -s ~/.aliases/i3/i3.conf ~/.config/i3/config

# create i3status config directory
mkdir -p ~/.config/i3status

# link toggle keyboard script
ln -s ~/.aliases/i3/toggle-kbl.sh  ~/.config/i3status/toggle-kbl.sh

# link i3script
ln -s ~/.aliases/i3/i3script.sh  ~/.config/i3status/i3script.sh

# link config file
ln -s ~/.aliases/i3/i3status.conf  ~/.config/i3status/config

# create dunst config directory
mkdir -p ~/.config/dunst/

# link config file
ln -s ~/.aliases/i3/dunstrc  ~/.config/dunst/dunstrc

# link rofi config
ln -s ~/.aliases/i3/rofi ~/.config/rofi

