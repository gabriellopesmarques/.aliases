#!/bin/bash

wget https://github.com/extrawurst/gitui/releases/download/v0.23.0/gitui-linux-musl.tar.gz && \
tar -xvzf gitui-linux-musl.tar.gz && \
sudo mv gitui /usr/local/bin/ && \
rm -rf gitui-linux-*.tar.gz && \
mkdir -p "$HOME"/.config/gitui/  && \
ln -s "$HOME"/.aliases/gitui/key_bindings.ron "$HOME"/.config/gitui/

