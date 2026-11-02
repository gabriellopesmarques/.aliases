#!/bin/bash

# install conky
sudo apt install conky-all

# create conky config directory
src="$HOME/.aliases/packages/conky/conkyrc"
dst="$HOME/.config/conky/conky.conf"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"

echo "exec --no-startup-id conky" >>~/.config/i3/config
