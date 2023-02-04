#!/bin/env bash

# install gnome-terminal
sudo apt-get install gnome-terminal

# import profiles
dconf load /org/gnome/terminal/legacy/profiles:/ < $HOME/.aliases/terminal/gnome-terminal/gnome-terminal-profiles.dconf

