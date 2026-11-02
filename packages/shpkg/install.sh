#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"
SHPKG_BIN="/usr/local/bin/shpkg"

sudo ln -sfn "$SHPKG_ROOT/shpkg" "$SHPKG_BIN"
printf 'installed: %s -> %s\n' "$SHPKG_BIN" "$SHPKG_ROOT/shpkg"
