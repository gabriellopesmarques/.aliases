#!/bin/bash

set -euo pipefail

user="$(logname)"
sudoers_file="/etc/sudoers.d/$user"

echo "$user ALL=(ALL) NOPASSWD:ALL" | sudo tee "$sudoers_file" >/dev/null
sudo chmod 0440 "$sudoers_file"
