#!/usr/bin/bash

# install dependencies
sudo apt update && \
sudo apt install tealdeer -y

config_path="$HOME/.config/tealdeer"

mkdir -p $config_path && \
ln -s "$HOME/.aliases/tldr/config.toml" "$config_path/config.toml"

tldr sh > /dev/null 2>&1

