#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s emacs >/dev/null 2>&1; then
  sudo apt purge -y emacs
fi
