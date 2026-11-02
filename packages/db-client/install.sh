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

sudo apt update &&
  sudo apt install mycli pgcli

append_source_once "$HOME/.zshrc" "source ~/.aliases/packages/db-client/dbcli.sh"
