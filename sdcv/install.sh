#!/usr/bin/env bash

here="$HOME/.aliases/sdcv"
directory_path="$HOME/.stardict/dic/"

# install dependencies
sudo apt update && \
sudo apt install sdcv

# arch repo has many dicts:
# https://aur.archlinux.org/packages?O=0&SeB=nd&K=Stardict&outdated=&SB=v&SO=d&PP=50&submit=Go

mkdir -p "$directory_path" && \
tar -xvzf "$here/DicAberto.tar.gz" -C "$directory_path"

