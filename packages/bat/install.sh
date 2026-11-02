#!/bin/bash

sudo apt install bat -y

src="$HOME/.aliases/packages/bat/TokyoNordStorm.tmTheme"
dst="$HOME/.config/bat/themes/TokyoNordStorm.tmTheme"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"

batcat cache --build
