#!/usr/bin/bash

# install dependencies
sudo apt update &&
  sudo apt install tealdeer -y

src="$HOME/.aliases/packages/tldr/config.toml"
dst="$HOME/.config/tealdeer/config.toml"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"

tldr sh >/dev/null 2>&1
