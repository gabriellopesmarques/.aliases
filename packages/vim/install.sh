#!/bin/bash

set -e

append_source_once() {
  local file="$1"
  local line="$2"

  touch "$file"
  if ! grep -qxF -- "$line" "$file"; then
    printf '%s\n' "$line" >>"$file"
  fi
}

## install vim
sudo apt install git curl vim -y

## load .aliases vim configs
append_source_once "$HOME/.vimrc" "source ~/.aliases/packages/vim/vimrc"
