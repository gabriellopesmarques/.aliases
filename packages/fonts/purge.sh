#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

sudo rm -rf \
  /usr/share/fonts/truetype/Space_Mono \
  /usr/share/fonts/truetype/victor_mono \
  /usr/share/fonts/truetype/jetbrains_mono \
  /usr/share/fonts/truetype/Glass_VT220 \
  /usr/share/fonts/truetype/fira \
  /usr/share/fonts/truetype/ibm_plex \
  /usr/share/fonts/truetype/recursive \
  /usr/share/fonts/truetype/google_sans_code

fc-cache -f >/dev/null 2>&1 || true
