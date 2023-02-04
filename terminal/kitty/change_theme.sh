#!/bin/env bash

themes_dir=$HOME/.aliases/terminal/kitty
kitty_conf=$HOME/.config/kitty/kitty.conf

if [[ ! -f $themes_dir/$1 ]]; then
    echo 'invalid theme!'
    exit 1
fi

rm -f $kitty_conf

ln -s $themes_dir/$1 $kitty_conf

exit 0
