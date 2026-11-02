#!/bin/bash
# install dialog
sudo apt install dialog -y

# link config file
src="$HOME/.aliases/packages/dialog/dialogrc"
dst="$HOME/.dialogrc"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"
