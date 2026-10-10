#!/bin/bash
# Restaura o wallpaper do tema atual (gravado por set_theme.sh).
# Usado no autostart do niri e pelo próprio set_theme.sh.

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/niri"
state_file="$state_dir/current-theme"
wallpapers_dir="$HOME/Pictures/Wallpapers/default"

theme="$(cat "$state_file" 2>/dev/null)"
if [[ -z "$theme" ]]; then
    theme="deep_blue"
fi

declare -A images=(
    ['deep_blue']="deep_blue-jeremy-bishop-DFJahLoBHK4-unsplash.jpg"
    ['hardcore']="hardcore-meduza-2036525035-steam.jpg"
    ['nord']="nord-city-lights.jpg"
    ['catppuccin_mocha']="catppuccin-mocha-abstract-swirls.jpg"
    ['monochrome']="monochrome-black-mountain.jpg"
    ['vt220']="vt220-specs.jpg"
)

declare -A modes=(
    ['deep_blue']="fill"
    ['hardcore']="center"
    ['nord']="fill"
    ['catppuccin_mocha']="fill"
    ['monochrome']="fill"
    ['vt220']="center"
)

image="$wallpapers_dir/${images[$theme]}"
if [[ ! -f "$image" ]]; then
    echo "wallpaper: image not found for theme '$theme': $image" >&2
    exit 1
fi

pkill -x swaybg 2>/dev/null
setsid swaybg -i "$image" -m "${modes[$theme]}" -c 000000 >/dev/null 2>&1 &
