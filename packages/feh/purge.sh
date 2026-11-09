#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s feh >/dev/null 2>&1; then
  sudo apt purge -y feh
fi

dst="$HOME/.fehbg"
if [[ -f "$dst" ]] && grep -q -- 'feh --no-fehbg --bg-fill' "$dst"; then
  rm -f "$dst"
elif [[ -e "$dst" ]]; then
  printf 'warning: %s was not created by this package, leaving it\n' "$dst" >&2
fi
