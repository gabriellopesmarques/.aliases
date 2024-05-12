#!/usr/bin/env bash

cd "$HOME/.src/tldr/" && sudo make uninstall
rm -rf "$HOME/.src/tldr/"
rm -rf "$HOME/.tldrc/"

