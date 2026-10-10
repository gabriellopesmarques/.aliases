#!/bin/bash

./install-niri.sh && \
ln -s $HOME/.aliases/niri/niri $HOME/.config/ && \
ln -s $HOME/.aliases/niri/waybar $HOME/.config/ && \
mkdir -p $HOME/.config/fuzzel && \
sudo apt install pipewire wireplumber playerctl pipewire-pulse && \
systemctl --user --now enable pipewire wireplumber pipewire-pulse && \
./set_theme.sh --deep_blue
