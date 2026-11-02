#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"
SHPKG_BIN="/usr/local/bin/shpkg"

if [[ -e "$SHPKG_BIN" && ! -L "$SHPKG_BIN" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$SHPKG_BIN" >&2
  exit 1
fi

sudo mkdir -p "$(dirname -- "$SHPKG_BIN")"
sudo ln -sfn "$SHPKG_ROOT/shpkg" "$SHPKG_BIN"
printf 'installed: %s -> %s\n' "$SHPKG_BIN" "$SHPKG_ROOT/shpkg"
