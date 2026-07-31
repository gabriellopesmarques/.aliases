#!/usr/bin/bash

dir="$HOME/.aliases/gitdelta"

sudo apt install curl jq -y

last_release=$(curl --silent https://api.github.com/repos/dandavison/delta/releases/latest | jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-gnu\\.tar\\.gz")) | .browser_download_url')

if [[ ! "$last_release" == http* ]]; then
  echo "[! error !] cant get gitdelta latest version from github api"
  exit 1
fi

tar_gz='gitdelta.tar.gz'
curl -fsSL -o "${dir}/${tar_gz}" "$last_release" &&
  tar -xvzf "${dir}/${tar_gz}" --strip-components=1 &&
  sudo mv "${dir}/delta" /usr/local/bin/ &&
  rm "${dir}/${tar_gz}" "${dir}/LICENSE" "${dir}/README.md"

git config --global core.pager delta &&
  git config --global interactive.diffFilter 'delta --color-only' &&
  git config --global delta.navigate true &&
  git config --global delta.side-by-side true &&
  git config --global delta.dark true &&
  git config --global merge.conflictStyle zdiff3
