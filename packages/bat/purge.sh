#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s bat >/dev/null 2>&1; then
  sudo apt purge -y bat
fi

theme="$HOME/.config/bat/themes/TokyoNordStorm.tmTheme"
if [[ -L "$theme" ]]; then
  rm -f "$theme"
elif [[ -e "$theme" ]]; then
  printf 'warning: %s is not a symlink, leaving it\n' "$theme" >&2
fi
rmdir "$HOME/.config/bat/themes" 2>/dev/null || true
rmdir "$HOME/.config/bat" 2>/dev/null || true
rm -rf "$HOME/.cache/bat"
