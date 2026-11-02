#!/bin/bash

set -euo pipefail

deb_url="https://github.com/gabriellopesmarques/niri-debian/releases/download/v26.04/niri_26.04-1_amd64.deb"
deb_file="/tmp/niri_v26.04-1_amd64.deb"

log() {
  printf '\n==> %s\n' "$*"
}

fail() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

need_command() {
  command -v "$1" >/dev/null 2>&1 || fail "Required command not found: $1"
}

main() {
  log "This package was built on/tested for Debian 13 (Trixie)."
  log "May work on Ubuntu, Mint, and other Debian derivatives - you're on your own."

  log "Downloading niri package from $deb_url"
  need_command wget
  wget -q --show-progress -O "$deb_file" "$deb_url" || fail "Failed to download .deb from $deb_url"

  log "Installing niri from $deb_file"
  sudo apt-get update
  sudo apt-get install -y "$deb_file"

  # Cleanup downloaded file
  rm -f "$deb_file"

  log 'Refreshing systemd user-unit metadata'
  systemctl --user daemon-reload || true

  log 'Checking installed binaries'
  for binary in niri niri-session xwayland-satellite Xwayland fuzzel waybar mako swaybg swaylock; do
    if command -v "$binary" >/dev/null 2>&1; then
      printf 'OK  %-22s %s\n' "$binary" "$(command -v "$binary")"
    else
      printf 'WARN %-22s not found in PATH\n' "$binary"
    fi
  done

  log 'Checking graphics device availability'
  if [[ -d /dev/dri ]]; then
    ls -l /dev/dri
  else
    printf '%s\n' 'Warning: /dev/dri does not exist. Niri may fail to start, especially inside a virtual machine.'
  fi

  cat <<'NEXT_STEPS'

Installation finished. No display manager was installed or enabled.

Next steps:
  1. Log out to a TTY (or reboot).
  2. Log in as your regular user.
  3. Start the session with: niri-session

If the screen becomes black or appears frozen, switch to another TTY with Ctrl+Alt+F3,
log in, and inspect:
  journalctl --user -u niri.service -b -n 150 --no-pager
  ls -l /dev/dri
  lspci -nnk | grep -A3 -E 'VGA|3D|Display'

Do not add a manual `spawn-at-startup "xwayland-satellite"` line: modern Niri
starts xwayland-satellite automatically when an X11 application needs it.
NEXT_STEPS
}

main

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

"$SHPKG_ROOT/shpkg" install fonts kitty wallpapers moc brave

link_path "$PKG_DIR/niri" "$HOME/.config/niri"
link_path "$PKG_DIR/waybar" "$HOME/.config/waybar"
link_path "$PKG_DIR/fuzzel" "$HOME/.config/fuzzel"

sudo apt install playerctl pipewire-pulse -y
systemctl --user --now enable pipewire-pulse || true

bash "$PKG_DIR/set_theme.sh" --deep_blue

append_source_once "$HOME/.bashrc" "source ~/.aliases/aliases.niri.sh"
append_source_once "$HOME/.zshrc" "source ~/.aliases/aliases.niri.sh"
