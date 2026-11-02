#!/bin/bash

dir="$HOME/.aliases/packages/dnsglobe"
repo='https://api.github.com/repos/514-labs/dnsglobe/releases/latest'

sudo apt install curl jq -y

last_release=$(curl --silent $repo | jq -r '.assets | .[] | select(.name == "dnsglobe-x86_64-unknown-linux-gnu.tar.xz") | .browser_download_url')

if [[ ! "$last_release" == http* ]]; then
  echo "[! error !] cant get dnsglobe latest version from github api"
  exit 1
fi

# download and install binary
curl -fsSL -o "${dir}/dnsglobe.tar.xz" "$last_release" &&
  cd "$dir" && tar --strip-components=1 --extract --verbose --xz --file "dnsglobe.tar.xz" &&
  sudo mv "$dir"/dnsglobe /usr/local/bin/

# clean downloaded files
find "$dir" -mindepth 1 ! -name 'install.sh' -delete
