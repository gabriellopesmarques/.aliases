#!/bin/bash
# SET THEME TOOL (niri/wayland)
# Troca o tema do niri, waybar, fuzzel, kitty e wallpaper (swaybg).
# Uso: set_theme.sh --nord | --catppuccin | --help

set -u

themes_dir="$HOME/.aliases/niri"
kitty_themes_dir="$HOME/.aliases/terminal/kitty"

niri_theme_link="$HOME/.config/niri/cfg/theme.kdl"
waybar_theme_link="$HOME/.config/waybar/style.css"
kitty_conf_link="$HOME/.config/kitty/kitty.conf"

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/niri"
state_file="$state_dir/current-theme"

wallpapers_script="$themes_dir/niri/scripts/wallpaper.sh"

set_theme() {
    theme="$1"

    echo "setting theme $theme"

    # validate theme files before touching anything
    for f in "$themes_dir/niri/themes/$theme.kdl" \
        "$themes_dir/waybar/themes/$theme.css" \
        "$themes_dir/fuzzel/themes/$theme.ini"; do
        if [[ ! -f "$f" ]]; then
            echo "missing theme file: $f" >&2
            exit 1
        fi
    done

    # change niri theme (borders / background-color)
    prev_niri_target="$(readlink "$niri_theme_link" 2>/dev/null || true)"
    rm -f "$niri_theme_link"
    ln -s "../themes/$theme.kdl" "$niri_theme_link"
    if command -v niri >/dev/null 2>&1; then
        if ! niri validate >/dev/null 2>&1; then
            echo "niri validate failed, reverting theme symlink" >&2
            niri validate >&2 || true
            rm -f "$niri_theme_link"
            if [[ -n "$prev_niri_target" ]]; then
                ln -s "$prev_niri_target" "$niri_theme_link"
            fi
            exit 1
        fi
        niri msg action load-config-file >/dev/null 2>&1 || true
    fi

    # change waybar theme (restart to apply)
    rm -f "$waybar_theme_link"
    ln -s "themes/$theme.css" "$waybar_theme_link"
    if pgrep -x waybar >/dev/null 2>&1; then
        pkill -x waybar
        setsid waybar >/dev/null 2>&1 &
    fi

    # change fuzzel theme (read on launch, no reload needed)
    mkdir -p "$HOME/.config/fuzzel"
    cat "$themes_dir/fuzzel/common.ini" "$themes_dir/fuzzel/themes/$theme.ini" \
        > "$HOME/.config/fuzzel/fuzzel.ini"

    # change kitty term theme
    rm -f "$kitty_conf_link"
    ln -s "$kitty_themes_dir/$theme.conf" "$kitty_conf_link"

    # change wallpaper (swaybg)
    mkdir -p "$state_dir"
    echo "$theme" > "$state_file"
    bash "$wallpapers_script"
}

usage() {
    echo -e '
    SET THEME TOOL (niri/wayland)
    change themes niri, waybar, fuzzel, kitty terminal and wallpaper

     options:
      --deep_blue
      --hardcore
      --nord
      --catppuccin
      --monochrome
      --vt220
      --help\t\tgive this help list
    '
}

while test $# -gt 0
do
    case "$1" in
        --deep_blue)
            set_theme deep_blue
        ;;
        --hardcore)
            set_theme hardcore
        ;;
        --nord)
            set_theme nord
        ;;
        --catppuccin)
            set_theme catppuccin_mocha
        ;;
        --monochrome)
            set_theme monochrome
        ;;
        --vt220)
            set_theme vt220
        ;;
        --help)
            usage
        ;;
        *)
            echo "$1 invalid option"
            echo "use: set_theme.sh --help"
            exit 1
        ;;

    esac
    shift
done
