#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

dst="${SHPKG_BIN:-/usr/local/bin/shpkg}"
if [[ -L "$dst" ]]; then
  sudo rm -f "$dst"
elif [[ -e "$dst" ]]; then
  printf 'warning: %s is not a symlink, leaving it\n' "$dst" >&2
fi

printf 'warning: the shpkg command will not be available after this purge\n' >&2
