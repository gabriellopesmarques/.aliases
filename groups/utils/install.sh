#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"

"$SHPKG_ROOT/shpkg" install utils-core fx bat sdcv glow gitui gitdelta dialog fetch
