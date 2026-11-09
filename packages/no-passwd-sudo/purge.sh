#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

user="$(logname 2>/dev/null || true)"
if [[ -z "$user" ]]; then
  user="${SUDO_USER:-${USER:-}}"
fi
if [[ -z "$user" ]] || [[ "$user" == root ]]; then
  printf 'error: could not determine the target user\n' >&2
  exit 1
fi

sudo rm -f "/etc/sudoers.d/$user"
sudo visudo -c
