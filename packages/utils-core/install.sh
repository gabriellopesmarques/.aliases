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

sudo apt install ncdu fdupes shellcheck shfmt eza fzf jq exfat-fuse dtrx smartmontools fio visidata yq -y

if [[ -d "/proc/acpi/button/lid" ]]; then
  sudo apt install network-manager acpi brightnessctl -y
fi

append_source_once "$HOME/.bashrc" "source ~/.aliases/aliases.utils.sh"
append_source_once "$HOME/.zshrc" "source ~/.aliases/aliases.utils.sh"
