#!/bin/bash

config_file="$HOME/.config/niri/cfg/input.kdl"
target_line='variant "alt-intl"'

if [[ ! -f "$config_file" ]]; then
    echo "Error: File $config_file not found!"
    exit 1
fi

is_commented=$(grep "^.*variant" "$config_file" | grep '//' | grep -c "$target_line")

if [[ $is_commented -gt 0 ]]; then
    sed -i "s|// $target_line|$target_line|" "$config_file"
else
    sed -i "s|$target_line|// $target_line|" "$config_file"
fi
