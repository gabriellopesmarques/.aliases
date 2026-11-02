#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"

"$SHPKG_ROOT/shpkg" install wallpapers

sudo apt install feh -y
{
  printf '#!/bin/sh\n'
  printf 'feh --no-fehbg --bg-fill %s\n' "$HOME/Pictures/Wallpapers/default/deep_blue-jeremy-bishop-DFJahLoBHK4-unsplash.jpg"
} >"$HOME/.fehbg"
sudo chmod 754 "$HOME/.fehbg"
