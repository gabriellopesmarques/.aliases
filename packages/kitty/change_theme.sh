#!/bin/env bash

themes_dir="$HOME/.aliases/packages/kitty"
kitty_conf="$HOME/.config/kitty/kitty.conf"

if [[ ! -f "$themes_dir/$1" ]]; then
  echo 'invalid theme!'
  exit 1
fi

if [[ -e "$kitty_conf" && ! -L "$kitty_conf" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$kitty_conf" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$kitty_conf")"
ln -sfn "$themes_dir/$1" "$kitty_conf"

exit 0
