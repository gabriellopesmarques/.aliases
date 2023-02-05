#!/bin/bash

sudo apt-get install git htop tree bc gnome-screenshot libnotify-bin at lm-sensors -y

## TODO: implements install by args
## ex.: ./install --utils --mail
## utils tools
#sudo apt-get install ntpdate       \ # set date/time witn ntp server
#                     brightnessctl \ # screen brightness control
#                     ncdu          \ # disk usage tool
#                     ranger        \ # console file manager
#                     shellcheck    \ # check syntax in shell scripts
#                     exa           \ # modern alternative to ls
#                     bat           \ # modren alternative to cat
#                     lnav          \ # ncurses-based log file viewer

## install email server and email reader
# sudo apt-get install postfix mutt -y

echo "~/.aliases/aliases.sh" >> $HOME/.bashrc

if command -v zsh &> /dev/null; then
    echo "~/.aliases/aliases.sh" >> $HOME/.zsh
fi

