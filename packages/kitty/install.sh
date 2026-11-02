#!/bin/env bash

kitty_conf="$HOME/.config/kitty/kitty.conf"

# install kitty
sudo apt install kitty -y

# link kitty config (default theme: deep_blue)
src="$HOME/.aliases/packages/kitty/deep_blue.conf"

if [[ -e "$kitty_conf" && ! -L "$kitty_conf" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$kitty_conf" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$kitty_conf")"
ln -sfn "$src" "$kitty_conf"
