#!/bin/bash

set -euo pipefail

SHPKG_ROOT="${SHPKG_ROOT:-$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)}"
PKG_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

link_path() {
  local src="$1"
  local dst="$2"

  if [[ -e "$dst" && ! -L "$dst" ]]; then
    printf 'error: %s exists and is not a symlink\n' "$dst" >&2
    return 1
  fi

  mkdir -p "$(dirname -- "$dst")"
  ln -sfn "$src" "$dst"
}

append_source_once() {
  local file="$1"
  local line="$2"

  touch "$file"
  if ! grep -qxF -- "$line" "$file"; then
    printf '%s\n' "$line" >>"$file"
  fi
}

"$SHPKG_ROOT/shpkg" install fonts kitty moc brave warpd feh

sudo apt install xorg i3 i3status feh pulseaudio pavucontrol rofi \
  scrot firefox-esr libnotify-bin at xclip -y

link_path "$PKG_DIR/i3" "$HOME/.config/i3"
mkdir -p "$HOME/.config/i3status"
link_path "$PKG_DIR/toggle-kbl.sh" "$HOME/.config/i3status/toggle-kbl.sh"
link_path "$PKG_DIR/i3script.sh" "$HOME/.config/i3status/i3script.sh"
link_path "$PKG_DIR/i3status.conf" "$HOME/.config/i3status/config"
link_path "$PKG_DIR/dunstrc" "$HOME/.config/dunst/dunstrc"
link_path "$PKG_DIR/rofi" "$HOME/.config/rofi"
link_path "$PKG_DIR/startup.sh" "$HOME/.config/i3status/startup.sh"

bash "$PKG_DIR/set_theme.sh" --deep_blue

append_source_once "$HOME/.bashrc" "source ~/.aliases/aliases.i3.sh"
append_source_once "$HOME/.zshrc" "source ~/.aliases/aliases.i3.sh"

sudo apt purge xterm -y
