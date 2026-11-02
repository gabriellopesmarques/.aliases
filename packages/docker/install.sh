#!/bin/bash

set -euo pipefail

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

sudo apt install curl -y
curl -fsSL https://get.docker.com -o "$tmp_dir/get-docker.sh"
sudo sh "$tmp_dir/get-docker.sh"
sudo usermod -aG docker "$USER"

echo "reboot or run 'newgrp docker'"
