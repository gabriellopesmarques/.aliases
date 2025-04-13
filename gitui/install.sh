#!/usr/bin/env bash

dir="$HOME/.aliases/gitui"

sudo apt install curl jq -y

last_release=$(curl --silent https://api.github.com/repos/gitui-org/gitui/releases/latest | jq -r '.assets | .[] | select(.name == "gitui-linux-x86_64.tar.gz") | .browser_download_url')

if [[ ! "$last_release" == http* ]]; then
    echo "[! error !] cant get gitui latest version from github api"
    exit 1
fi

curl -L -o "${dir}/gitui.tar.gz" "$last_release" && \
tar -xzf "$dir"/*.tar.gz -C "$dir" && \
sudo mv "$dir"/gitui /usr/local/bin/ && \
rm -rf "$dir"/*.tar.gz && \
mkdir -p "$HOME"/.config/gitui/  && \
ln -s "$HOME"/.aliases/gitui/key_bindings.ron "$HOME"/.config/gitui/

