#!/usr/bin/env bash

src="$HOME/.aliases/packages/wallpapers/default"
dst="$HOME/Pictures/Wallpapers/default"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"
