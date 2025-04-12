#!/usr/bin/env bash

dir="$HOME/.aliases/gitui"

for cmd in wget jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "[! error !] required package ${cmd} is not installed"
        exit 1
    fi
done

last_release=$(wget -q -O - https://api.github.com/repos/gitui-org/gitui/releases/latest | jq -r '.assets | .[] | select(.name == "gitui-linux-x86_64.tar.gz") | .browser_download_url')

if [[ ! "$last_release" == http* ]]; then
    echo "[! error !] cant get gitui latest version from github api"
    exit 1
fi

wget -P "$dir" "$last_release" && \
tar -xzf "$dir"/*.tar.gz -C "$dir" && \
sudo mv "$dir"/gitui /usr/local/bin/ && \
rm -rf "$dir"/*.tar.gz && \
mkdir -p "$HOME"/.config/gitui/  && \
ln -s "$HOME"/.aliases/gitui/key_bindings.ron "$HOME"/.config/gitui/

