#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s dialog >/dev/null 2>&1; then
  sudo apt purge -y dialog
fi

dst="$HOME/.dialogrc"
if [[ -L "$dst" ]]; then
  rm -f "$dst"
elif [[ -e "$dst" ]]; then
  printf 'warning: %s is not a symlink, leaving it\n' "$dst" >&2
fi
