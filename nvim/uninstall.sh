#!/usr/bin/env bash

rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.config/nvim"

sudo make -C ~/.src/neovim uninstall && rm -rf ~/.src/neovim
