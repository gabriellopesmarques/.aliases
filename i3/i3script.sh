#!/bin/bash
i3status --config  $HOME/.config/i3status/config | while :
do
    read line
    LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
    VARIANT=$(setxkbmap -query | awk '/variant/{print $2}')
    echo "$LAYOUT:$VARIANT | $line" || exit 1
done

