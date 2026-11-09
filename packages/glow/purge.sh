#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s glow >/dev/null 2>&1; then
  sudo apt purge -y glow
fi

dst="$HOME/.config/glow/nord.json"
if [[ -L "$dst" ]]; then
  rm -f "$dst"
elif [[ -e "$dst" ]]; then
  printf 'warning: %s is not a symlink, leaving it\n' "$dst" >&2
fi

sudo rm -f /etc/apt/keyrings/charm.gpg
sudo rm -f /etc/apt/sources.list.d/charm.list
sudo apt update
