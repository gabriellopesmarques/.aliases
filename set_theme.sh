#!/bin/bash

set_theme () {
    theme="$1"

    echo "setting theme $theme"

    declare -A wallpapers
    wallpapers['deep_blue']="--bg-fill $HOME/Pictures/Wallpapers/default/deep_blue-jeremy-bishop-DFJahLoBHK4-unsplash.jpg"
    wallpapers['hardcore']="--bg-center $HOME/Pictures/Wallpapers/default/hardcore-meduza-2036525035-steam.jpg"
    wallpapers['nord']="--bg-fill $HOME/Pictures/Wallpapers/default/nord-city-lights.jpg"
    wallpapers['catppuccin_mocha']="--bg-fill $HOME/Pictures/Wallpapers/default/catppuccin-mocha-abstract-swirls.jpg"
    wallpapers['monochrome']="--bg-fill $HOME/Pictures/Wallpapers/default/monochrome-black-mountain.jpg"
    wallpapers['vt220']="--bg-center $HOME/Pictures/Wallpapers/default/vt220-specs.jpg"

    themes_dir="$HOME/.aliases/terminal/kitty"
    kitty_conf="$HOME/.config/kitty/kitty.conf"

    # change i3wm theme
    rm -f "$HOME/.config/i3/theme"
    ln -s "$HOME/.config/i3/themes/$theme.theme" "$HOME/.config/i3/theme"

    # change rofi theme
    echo '@theme "'"$theme"'"' > "$HOME/.config/rofi/config.rasi"
    cat "$HOME/.config/rofi/common_settings.rasi" >> "$HOME/.config/rofi/config.rasi"


    # change kitty term theme
    rm -f "$kitty_conf"
    ln -s "$themes_dir/$theme.conf" "$kitty_conf"

    # change wallpaper
    feh ${wallpapers[$theme]}
}

usage () {
    echo -e '
    SET THEME TOOL
    change themes i3wm, rofi, kitty terminal and change wallpaper

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


