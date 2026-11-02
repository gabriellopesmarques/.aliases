#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"

"$SHPKG_ROOT/shpkg" install omz aliases utils tldr vim set-vim-editor
