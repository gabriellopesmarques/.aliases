#!/bin/bash

browser=$1
prompt=$2
query=$(echo "" | fuzzel --dmenu --prompt="$prompt: ")

if [[ -z "$query" ]]; then
    exit 1
fi

case "$prompt" in
    AI)
        url="https://www.google.com/search?q=$query&udm=50&aep=1&ntc=1"
    ;;
    YouTube)
        url="https://youtube.com/results?search_query=$query"
    ;;
    Google)
        url="https://www.google.com/search?q=$query"
    ;;
    Translate)
        url="https://translate.google.com/?sl=en&tl=pt&op=translate&text=$query"
    ;;
    *)
        echo 'ERROR: url not mapped' >> $HOME/prompt.log
        exit 1
    ;;
esac

$browser "$url"

