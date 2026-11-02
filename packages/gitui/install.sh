#!/usr/bin/env bash

set -e

dir="$HOME/.aliases/packages/gitui"

sudo apt install curl jq -y

last_release=$(curl --silent https://api.github.com/repos/gitui-org/gitui/releases/latest | jq -r '.assets | .[] | select(.name == "gitui-linux-x86_64.tar.gz") | .browser_download_url' || true)

if [[ ! "$last_release" == http* ]]; then
  echo "[! error !] cant get gitui latest version from github api"
  exit 1
fi

curl -fsSL -o "${dir}/gitui.tar.gz" "$last_release" &&
  tar -xzf "$dir"/*.tar.gz -C "$dir" &&
  sudo mv "$dir"/gitui /usr/local/bin/ &&
  rm -rf "$dir"/*.tar.gz || exit 1

src="$HOME/.aliases/packages/gitui/key_bindings.ron"
dst="$HOME/.config/gitui/key_bindings.ron"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"
