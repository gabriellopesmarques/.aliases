#!/bin/bash

dir="$HOME"/.aliases/packages/warpd/warpd-repo

git clone --branch 'v1.3.5' https://github.com/rvaiya/warpd.git "$dir"
cd "$dir" || exit 1

echo "installing dependencies . . ."
sudo apt install -y \
  libxi-dev \
  libxinerama-dev \
  libxft-dev \
  libxfixes-dev \
  libxtst-dev \
  libx11-dev \
  libcairo2-dev \
  libxkbcommon-dev \
  libwayland-dev &&
  make && sudo make install &&
  rm -rf "$dir"
