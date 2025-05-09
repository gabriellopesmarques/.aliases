#!/bin/bash

# install i3 and utils
sudo apt install xorg i3 i3status feh pulseaudio pavucontrol rofi \
    gnome-screenshot firefox-esr libnotify-bin at -y


# link config file
ln -s "$HOME/.aliases/i3/i3" "$HOME/.config/i3"

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

# link startup file
ln -s ~/.aliases/i3/startup.sh ~/.config/i3status/startup.sh
