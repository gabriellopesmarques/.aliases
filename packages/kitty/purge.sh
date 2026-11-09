#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s kitty >/dev/null 2>&1; then
  sudo apt purge -y kitty
fi

dst="$HOME/.config/kitty/kitty.conf"
if [[ -L "$dst" ]]; then
  rm -f "$dst"
elif [[ -e "$dst" ]]; then
  printf 'warning: %s is not a symlink, leaving it\n' "$dst" >&2
fi
rmdir "$HOME/.config/kitty" 2>/dev/null || true

state_file="${XDG_STATE_HOME:-$HOME/.local/state}/shpkg/installed"
for dep in i3wm niri; do
  if grep -qxF -- "$dep" "$state_file" 2>/dev/null; then
    printf 'warning: %s is still installed and expects the kitty config\n' "$dep" >&2
  fi
done
