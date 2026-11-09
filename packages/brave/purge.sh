#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

if dpkg -s brave-browser >/dev/null 2>&1; then
  sudo apt purge -y brave-browser
fi
sudo rm -f /usr/share/keyrings/brave-browser-archive-keyring.gpg
sudo rm -f /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
