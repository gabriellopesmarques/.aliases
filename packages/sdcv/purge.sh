#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s sdcv >/dev/null 2>&1; then
  sudo apt purge -y sdcv
fi

rm -rf "$HOME/.stardict/dic/DicAberto"
rmdir "$HOME/.stardict/dic" 2>/dev/null || true
rmdir "$HOME/.stardict" 2>/dev/null || true
