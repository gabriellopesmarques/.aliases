#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

dst="$HOME/Pictures/Wallpapers/default"
if [[ -L "$dst" ]]; then
  rm -f "$dst"
elif [[ -e "$dst" ]]; then
  printf 'warning: %s is not a symlink, leaving it\n' "$dst" >&2
fi
rmdir "$HOME/Pictures/Wallpapers" 2>/dev/null || true
