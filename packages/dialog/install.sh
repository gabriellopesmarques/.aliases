#!/bin/bash
# install dialog
sudo apt install dialog -y

# link config file
ln -s ~/.aliases/packages/dialog/dialogrc ~/.dialogrc
