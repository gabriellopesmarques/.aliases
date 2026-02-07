#!/bin/bash

required_pkgs=("shfmt" "shellcheck")

for pkg in "${required_pkgs[@]}"; do
    if ! command -v "$pkg" &> /dev/null; then
        echo "$pkg is not installed."
        echo "shfmt and shellcheck is required"
        exit 78
    fi
done

file_name="$1"

shfmt -d -i 2 "$file_name" && \
    shellcheck -e SC2028,SC2148 "$file_name"

