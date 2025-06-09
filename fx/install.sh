#!/usr/bin/bash

dir="$HOME/.aliases/fx"

sudo apt install curl jq -y

last_release=$(curl --silent https://api.github.com/repos/antonmedv/fx/releases/latest | jq -r '.assets | .[] | select(.name == "fx_linux_amd64") | .browser_download_url')

if [[ ! "$last_release" == http* ]]; then
    echo "[! error !] cant get fx latest version from github api"
    exit 1
fi

curl -fsSL -o "${dir}/fx" "$last_release" && \
sudo chmod +x "${dir}/fx" && \
sudo mv "$dir"/fx /usr/local/bin/

