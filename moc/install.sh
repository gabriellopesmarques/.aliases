#!/bin/env bash

dir="$HOME/.moc"

sudo apt install moc -y

mkdir $dir

ln -s ~/.aliases/moc/config $dir/config
ln -s ~/.aliases/moc/keymap $dir/keymap

