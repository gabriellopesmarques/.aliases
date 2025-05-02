#!/bin/bash

HAS_BATTERY=$(acpi -b 2>/dev/null | grep -q "Battery" && echo true || echo false)

i3status --config  $HOME/.config/i3status/config | while :
do
    read line
    LAYOUT=$(setxkbmap -query | awk '/layout/{print $2}')
    VARIANT=$(setxkbmap -query | awk '/variant/{print $2}')

    if [ "$HAS_BATTERY" = true ]; then
        BATTERY=$(acpi -b | awk -F', ' '{gsub(/ remaining/, "", $3); print $2, $3}')
        echo -n "$LAYOUT:$VARIANT | BAT: $BATTERY | $line" || exit 1
    else
        echo -n "$LAYOUT:$VARIANT | $line" || exit 1
    fi
done

