#!/usr/bin/env bash

dir="$HOME/.aliases/gitfiend"
sudo apt install libsecret-1-0 libsecret-common -y
wget -P "$dir" https://gitfiend.com/resources/GitFiend_0.42.1_amd64.deb && \
sudo dpkg -i "$dir"/GitFiend_0.42.1_amd64.deb && \
rm -f "$dir"/GitFiend_0.42.1_amd64.deb

