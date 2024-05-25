#!/usr/bin/env bash

sudo cmake --build "$HOME/.src/neovim/build" --target uninstall && \
    rm -rf "$HOME/.src/neovim" && \
    rm -rf "$HOME/.local/share/nvim" && \
    rm -rf "$HOME/.local/state/nvim" && \
    sudo rm -rf "$HOME/.config/nvim"
