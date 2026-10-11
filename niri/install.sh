#!/bin/bash

set -Eeuo pipefail

# Minimal Niri installation for Debian 13 (Trixie).
# Debian packages are used for dependencies; Niri and xwayland-satellite
# are compiled from pinned upstream tags and installed under /usr/local.

niri_version="v26.04"
xwayland_satellite_version="v0.8.2"
source_root="${HOME}/.local/src"
niri_source="${source_root}/niri"
xwayland_satellite_source="${source_root}/xwayland-satellite"

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

if [[ "${EUID}" -eq 0 ]]; then
    fail "Run this script as a regular user, not as root. It will call sudo when needed."
fi

need_command sudo
need_command git
need_command apt-cache
need_command dpkg-query

if [[ ! -r /etc/os-release ]]; then
    fail "Cannot identify the operating system: /etc/os-release is missing."
fi
# shellcheck disable=SC1091
source /etc/os-release

if [[ "${ID:-}" != "debian" || "${VERSION_CODENAME:-}" != "trixie" ]]; then
    fail "This script targets Debian 13 (Trixie). Detected: ${PRETTY_NAME:-unknown}."
fi

printf '%s\n' \
    'This script installs Niri on Debian 13 using official Debian packages' \
    'for dependencies, and builds pinned upstream source releases for Niri' \
    'and xwayland-satellite. It does not install a display manager or GNOME.'
printf '\nNiri: %s\nxwayland-satellite: %s\n' \
    "$niri_version" "$xwayland_satellite_version"

if dpkg-query -W -f='${db:Status-Status}\n' gdm3 gnome-shell task-gnome-desktop 2>/dev/null | grep -qx installed; then
    printf '\nWarning: a GNOME/GDM package appears to be installed already.\n'
    printf '%s\n' 'This script will not remove existing desktop packages.'
fi

log 'Refreshing Debian package metadata'
sudo apt-get update

build_packages=(
    build-essential
    ca-certificates
    clang
    cargo
    git
    pkg-config
    rustc
    libdbus-1-dev
    libdisplay-info-dev
    libegl1-mesa-dev
    libgbm-dev
    libinput-dev
    libpango1.0-dev
    libpipewire-0.3-dev
    libseat-dev
    libsystemd-dev
    libudev-dev
    libwayland-dev
    libxcb-cursor-dev
    libxcb1-dev
    libxkbcommon-dev
)

runtime_packages=(
    dbus-user-session
    fuzzel
    gnome-keyring
    kitty
    mako-notifier
    mate-polkit
    pipewire
    polkitd
    swaybg
    swaylock
    waybar
    wireplumber
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xwayland
)

log 'Checking every requested package exists in the configured Debian repositories'
missing_packages=()
for package in "${build_packages[@]}" "${runtime_packages[@]}"; do
    if ! apt-cache show "$package" 2>/dev/null | grep '^Package:' >/dev/null; then
        missing_packages+=("$package")
    fi
done

if ((${#missing_packages[@]} > 0)); then
    printf 'The following packages are unavailable from the configured APT sources:\n' >&2
    printf '  - %s\n' "${missing_packages[@]}" >&2
    printf '\nNo packages have been installed by this script. Check /etc/apt/sources.list* and retry.\n' >&2
    exit 1
fi

log 'Installing build dependencies and minimal Wayland session packages'
sudo apt-get install --no-install-recommends \
    "${build_packages[@]}" \
    "${runtime_packages[@]}"

need_command cargo
need_command rustc

rust_version="$(rustc --version | awk '{print $2}')"
if [[ "$(printf '%s\n' 1.85.0 "$rust_version" | sort -V | head -n1)" != "1.85.0" ]]; then
    fail "Rust 1.85.0 or newer is required; detected rustc ${rust_version}. No source build was started."
fi

mkdir -p "$source_root"

checkout_tag() {
    local repository_url="$1"
    local checkout_dir="$2"
    local tag="$3"

    if [[ ! -d "$checkout_dir/.git" ]]; then
        if [[ -e "$checkout_dir" ]]; then
            fail "Source path exists but is not a Git repository: $checkout_dir"
        fi
        git clone --depth 1 --branch "$tag" "$repository_url" "$checkout_dir"
    else
        local current_remote
        current_remote="$(git -C "$checkout_dir" remote get-url origin)"
        [[ "$current_remote" == "$repository_url" ]] || fail "Unexpected origin in $checkout_dir: $current_remote"
        if [[ -n "$(git -C "$checkout_dir" status --porcelain)" ]]; then
            fail "Source tree has local changes: $checkout_dir. Review or clean it before running this script again."
        fi
        git -C "$checkout_dir" fetch --depth 1 origin "refs/tags/${tag}:refs/tags/${tag}"
        git -C "$checkout_dir" checkout --detach "$tag"
    fi
}

log "Downloading Niri ${niri_version} source"
checkout_tag "https://github.com/niri-wm/niri.git" "$niri_source" "$niri_version"

log 'Building Niri (this can take a while)'
(
    cd "$niri_source"
    cargo build --locked --release
)

[[ -x "$niri_source/target/release/niri" ]] || fail 'Niri build completed without producing target/release/niri.'
[[ -f "$niri_source/resources/niri-session" ]] || fail 'Expected upstream resource resources/niri-session was not found.'
[[ -f "$niri_source/resources/niri.service" ]] || fail 'Expected upstream resource resources/niri.service was not found.'
[[ -f "$niri_source/resources/niri-shutdown.target" ]] || fail 'Expected upstream resource resources/niri-shutdown.target was not found.'

log "Downloading xwayland-satellite ${xwayland_satellite_version} source"
checkout_tag "https://github.com/Supreeeme/xwayland-satellite.git" "$xwayland_satellite_source" "$xwayland_satellite_version"

log 'Building xwayland-satellite (this can take a while)'
(
    cd "$xwayland_satellite_source"
    cargo build --locked --release
)

[[ -x "$xwayland_satellite_source/target/release/xwayland-satellite" ]] || fail 'xwayland-satellite build completed without producing target/release/xwayland-satellite.'

log 'Installing locally built binaries and upstream Niri session files'
sudo install -D -m 0755 "$niri_source/target/release/niri" /usr/local/bin/niri
sudo install -D -m 0755 "$niri_source/resources/niri-session" /usr/local/bin/niri-session
sudo install -D -m 0755 "$xwayland_satellite_source/target/release/xwayland-satellite" /usr/local/bin/xwayland-satellite
sudo install -D -m 0644 "$niri_source/resources/niri.service" /etc/systemd/user/niri.service
sudo install -D -m 0644 "$niri_source/resources/niri-shutdown.target" /etc/systemd/user/niri-shutdown.target
sudo install -D -m 0644 "$niri_source/resources/niri.desktop" /usr/local/share/wayland-sessions/niri.desktop

# Select GTK for the basic portals without installing the GNOME portal backend.
# GNOME-specific screencasting will not be available with this minimal setup.
sudo install -d -m 0755 /usr/local/share/xdg-desktop-portal
sudo tee /usr/local/share/xdg-desktop-portal/niri-portals.conf >/dev/null <<'PORTALS_CONF'
[preferred]
default=gtk;
org.freedesktop.impl.portal.Access=gtk;
org.freedesktop.impl.portal.Notification=gtk;
org.freedesktop.impl.portal.Secret=gnome-keyring;
PORTALS_CONF

log 'Refreshing systemd user-unit metadata'
systemctl --user daemon-reload || true

log 'Checking installed binaries'
for binary in niri niri-session xwayland-satellite Xwayland kitty fuzzel waybar mako swaybg swaylock; do
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

Installation finished. No display manager was installed or enabled by this script.

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

This script intentionally does not install xdg-desktop-portal-gnome, GDM, GNOME Shell,
or a full desktop environment. GNOME-specific screen-sharing portal support is therefore
not included; it can be added separately if you later need it.
NEXT_STEPS
