#!/bin/bash

set -euo pipefail

if [[ "${SHPKG_PURGE_CONFIRMED:-0}" != 1 ]]; then
  printf 'error: run this script through "shpkg purge"\n' >&2
  exit 1
fi

printf 'warning: purging postfix may affect the system mail transport\n' >&2
if dpkg -s postfix >/dev/null 2>&1 || dpkg -s mutt >/dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt purge -y postfix mutt
fi
