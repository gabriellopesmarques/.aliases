#!/bin/env bash

dir="$HOME/.moc"

sudo apt install moc -y

mkdir $dir

if [ -f $dir/config ]; then
    rm -f $dir/config
fi

ln -s ~/.aliases/moc/config $dir/config

if [ -f $dir/keymap ]; then
    rm -f $dir/keymap
fi

ln -s ~/.aliases/moc/keymap $dir/keymap
