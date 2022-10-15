#!/bin/bash 

#
# toggle keyboard layout
#

VARIANT=$(setxkbmap -query | awk '/variant/{print $2}') 

if [[ $VARIANT == "alt-intl" ]]
then
    setxkbmap -layout us
    echo "us"
else
    setxkbmap -layout us -variant alt-intl
    echo "us alt-intl"
fi
