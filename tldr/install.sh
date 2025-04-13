#!/bin/bash

# install dependencies
sudo apt update && \
sudo apt install git -y

## download source and compile
if ! command -v tldr &> /dev/null; then
    mkdir "$HOME/.src"
    git clone https://github.com/tldr-pages/tldr-c-client.git "$HOME/.src/tldr"

    sudo apt install build-essential -y

    cd "$HOME/.src/tldr"
    sudo ./deps.sh
    make
    sudo make install
fi

tldr sh > /dev/null 2>&1

echo "installed! :D"
