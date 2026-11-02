#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"

# shellcheck disable=SC1091
source "$SHPKG_ROOT/groups/common.sh"

group_select "env-i3wm" omz aliases utils tldr tmux vim set-vim-editor neovim docker i3wm
