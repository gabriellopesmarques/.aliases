#!/bin/bash

set -Eeuo pipefail

# Minimal Niri installation for Debian 13 (Trixie).
# Debian packages are used for dependencies; Niri and xwayland-satellite
# are compiled from pinned upstream tags in a Docker container and installed under /usr/local.
# Build tools (Rust, C/C++, Cargo cache) stay in Docker volumes, not on the host.

niri_version="v26.04"
xwayland_satellite_version="v0.8.2"
cargo_volume="niri-cargo-cache"

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
need_command docker

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
    'and xwayland-satellite in a Docker container. It does not install a display manager or GNOME.'
printf '\nNiri: %s\nxwayland-satellite: %s\n' \
    "$niri_version" "$xwayland_satellite_version"

if dpkg-query -W -f='${db:Status-Status}\n' gdm3 gnome-shell task-gnome-desktop 2>/dev/null | grep -qx installed; then
    printf '\nWarning: a GNOME/GDM package appears to be installed already.\n'
    printf '%s\n' 'This script will not remove existing desktop packages.'
fi

log 'Refreshing Debian package metadata'
sudo apt-get update

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
for package in "${runtime_packages[@]}"; do
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

log 'Installing minimal Wayland session packages (runtime dependencies only)'
sudo apt-get install --no-install-recommends \
    "${runtime_packages[@]}"

# Build niri and xwayland-satellite in Docker container
log 'Building Niri and xwayland-satellite in Docker container'

# Create named volume for Cargo cache (persists between builds, easy to clean up)
if ! docker volume inspect "$cargo_volume" >/dev/null 2>&1; then
    log "Creating Docker volume '$cargo_volume' for Cargo cache"
    docker volume create "$cargo_volume" >/dev/null
fi

# Build the Docker image
log "Building Docker image for niri ${niri_version} and xwayland-satellite ${xwayland_satellite_version}"
docker build \
    --build-arg NIRI_VERSION="${niri_version}" \
    --build-arg XWAYLAND_SATELLITE_VERSION="${xwayland_satellite_version}" \
    -t niri-builder \
    -f "${HOME}/.aliases/niri/Dockerfile.build" \
    "${HOME}/.aliases/niri"

# Run the container with Cargo cache volume mounted
log 'Running build container (this can take a while)'
container_id=$(docker run -d \
    -v "${cargo_volume}:/root/.cargo" \
    niri-builder)

# Wait for container to finish and check exit code
if ! docker wait "$container_id" | grep -q '^0$'; then
    docker logs "$container_id"
    docker rm "$container_id"
    fail 'Docker build failed. Check logs above.'
fi

# Copy artifacts from container to a temporary directory on host
log 'Copying built artifacts from container'
tmp_dir=$(mktemp -d -t niri-build-XXXXXX)
trap 'rm -rf "$tmp_dir"' EXIT

docker cp "${container_id}:/out/niri" "${tmp_dir}/niri"
docker cp "${container_id}:/out/niri-session" "${tmp_dir}/niri-session"
docker cp "${container_id}:/out/niri.service" "${tmp_dir}/niri.service"
docker cp "${container_id}:/out/niri-shutdown.target" "${tmp_dir}/niri-shutdown.target"
docker cp "${container_id}:/out/niri.desktop" "${tmp_dir}/niri.desktop"
docker cp "${container_id}:/out/xwayland-satellite" "${tmp_dir}/xwayland-satellite"

# Clean up container
docker rm "$container_id"

# Verify artifacts exist
[[ -x "${tmp_dir}/niri" ]] || fail 'Niri binary not found after docker cp.'
[[ -f "${tmp_dir}/niri-session" ]] || fail 'niri-session not found after docker cp.'
[[ -f "${tmp_dir}/niri.service" ]] || fail 'niri.service not found after docker cp.'
[[ -f "${tmp_dir}/niri-shutdown.target" ]] || fail 'niri-shutdown.target not found after docker cp.'
[[ -f "${tmp_dir}/niri.desktop" ]] || fail 'niri.desktop not found after docker cp.'
[[ -x "${tmp_dir}/xwayland-satellite" ]] || fail 'xwayland-satellite binary not found after docker cp.'

log 'Installing locally built binaries and upstream Niri session files'
sudo install -D -m 0755 "${tmp_dir}/niri" /usr/local/bin/niri
sudo install -D -m 0755 "${tmp_dir}/niri-session" /usr/local/bin/niri-session
sudo install -D -m 0755 "${tmp_dir}/xwayland-satellite" /usr/local/bin/xwayland-satellite
sudo install -D -m 0644 "${tmp_dir}/niri.service" /etc/systemd/user/niri.service
sudo install -D -m 0644 "${tmp_dir}/niri-shutdown.target" /etc/systemd/user/niri-shutdown.target
sudo install -D -m 0644 "${tmp_dir}/niri.desktop" /usr/local/share/wayland-sessions/niri.desktop

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

# Prompt for cleanup
printf '\n'
read -p "Remove Docker image 'niri-builder' and Cargo cache volume ('$cargo_volume')? [y/N] " -n 1 -r
printf '\n'
if [[ $REPLY =~ ^[Yy]$ ]]; then
    log 'Removing Docker image niri-builder...'
    docker rmi niri-builder 2>/dev/null || true
    log 'Removing Cargo cache volume...'
    docker volume rm "$cargo_volume" 2>/dev/null || true
    log 'Cleanup complete.'
else
    log 'Image and volume kept.'
    log "  To remove later: docker rmi niri-builder && docker volume rm $cargo_volume"
    log "  To list volumes: docker volume ls"
    log "  To list images: docker images"
fi