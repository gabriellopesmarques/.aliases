#!/bin/env bash

dir="$HOME/.moc"

link_path() {
  local src="$1"
  local dst="$2"

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    printf 'error: %s exists and is not a symlink\n' "$dst" >&2
    exit 1
  fi

  mkdir -p "$(dirname -- "$dst")"
  ln -sfn "$src" "$dst"
}

sudo apt install moc -y

mkdir -p "$dir"

link_path "$HOME/.aliases/packages/moc/config" "$dir/config"
chmod 600 "$HOME/.moc/config"
link_path "$HOME/.aliases/packages/moc/keymap" "$dir/keymap"
