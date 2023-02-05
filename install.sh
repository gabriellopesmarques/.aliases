#!/bin/bash

sudo apt install git zsh htop tree bc lm-sensors -y

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

# add aliases in bash
echo "~/.aliases/aliases.sh" >> $HOME/.bashrc

# add aliases in zsh
echo "~/.aliases/aliases.sh" >> $HOME/.zsh

