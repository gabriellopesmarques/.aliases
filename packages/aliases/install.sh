#!/bin/bash

set -euo pipefail

append_source_once() {
  local file="$1"
  local line="$2"

  touch "$file"
  if ! grep -qxF -- "$line" "$file"; then
    printf '%s\n' "$line" >>"$file"
  fi
}

sudo apt install git zsh htop tree bc lm-sensors aria2 at w3m -y

append_source_once "$HOME/.bashrc" "source ~/.aliases/aliases.sh"
append_source_once "$HOME/.zshrc" "source ~/.aliases/aliases.sh"
