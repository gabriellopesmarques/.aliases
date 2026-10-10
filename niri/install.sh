#!/bin/bash

./install-niri.sh && \
ln -s $HOME/.aliases/niri/niri $HOME/.config/ && \
ln -s $HOME/.aliases/niri/waybar $HOME/.config/ && \
sudo apt install pipewire wireplumber pipewire-pulse && \
systemctl --user --now enable pipewire wireplumber pipewire-pulse

