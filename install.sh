#!/bin/bash

sudo apt install git zsh htop tree bc lm-sensors \
     bc aria2 libnotify-bin at w3m -y  # aliases.sh dependencies

## TODO: implements install by args
## ex.: ./install --utils --mail
## utils tools
#sudo apt-get install brightnessctl \ # screen brightness control
#                     btop          \ # resource monitor that shows usage and stats for processor, memory, disks, network and processes.
#                     ncdu          \ # disk usage tool
#                     ranger        \ # console file manager or nnn or vifm
#                     shellcheck    \ # check syntax in shell scripts
#                     exa           \ # modern alternative to ls
#                     fzf           \ # general-purpose command-line fuzzy finder
#                     lnav            # ncurses-based log file viewer


## install email server and email reader
# sudo apt-get install postfix mutt -y

## install docker
# curl -fsSL https://get.docker.com -o get-docker.sh
# sudo sh ./get-docker.sh
## add current user to docker group
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
## test run docker without sudo
# docker run hello-world


# nix-env -iA nixpkgs.trashy         # trash in terminal

## terminal interface for git (i really need it?!)
# nix-env -iA nixpkgs.gitui ## or lazygit

## markdown reader (golang)
# nix-env -iA nixpkgs.glow

# add aliases in bash
echo "source ~/.aliases/aliases.sh" >> $HOME/.bashrc

