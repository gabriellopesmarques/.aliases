#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"

# shellcheck disable=SC1091
source "$SHPKG_ROOT/groups/common.sh"

group_select "light" omz aliases utils tldr vim set-vim-editor
