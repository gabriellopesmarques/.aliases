#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

sudo rm -f /usr/local/bin/warpd
sudo rm -f /usr/local/share/man/man1/warpd.1.gz
