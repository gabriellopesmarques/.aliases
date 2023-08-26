#!/usr/bin/env bash

dir="$HOME/.aliases/gitui"

wget -P "$dir" https://github.com/extrawurst/gitui/releases/download/v0.23.0/gitui-linux-musl.tar.gz && \
tar -xzf "$dir"/gitui-linux-musl.tar.gz -C "$dir" && \
sudo mv "$dir"/gitui /usr/local/bin/ && \
rm -rf "$dir"/gitui-linux-*.tar.gz && \
mkdir -p "$HOME"/.config/gitui/  && \
ln -s "$HOME"/.aliases/gitui/key_bindings.ron "$HOME"/.config/gitui/

