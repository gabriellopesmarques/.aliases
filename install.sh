#!/bin/bash

install_aliases () {
    echo "installing aliases"
    sudo apt install git zsh htop tree bc lm-sensors bc aria2 libnotify-bin at w3m -y  # aliases.sh dependencies
    # add aliases in bash
    echo "source ~/.aliases/aliases.sh" >> "$HOME"/.bashrc
}

install_utils () {
    echo "installing utils tools"
    sudo apt install ncdu shellcheck exa fzf -y
    #brightnessctl

    bash "$HOME"/.aliases/bat/install.sh     && \
    bash "$HOME"/.aliases/glow/install.sh    && \
    bash "$HOME"/.aliases/dialog/install.sh  && \
    sudo bash "$HOME"/.aliases/fetch/install.sh

    ## load utils aliases
    echo "source ~/.aliases/aliases.utils.sh" >> "$HOME"/.bashrc
    echo "source ~/.aliases/aliases.utils.sh" >> "$HOME"/.zshrc
}

install_docker () {
     echo "install docker"
     curl -fsSL https://get.docker.com -o get-docker.sh && \
     sudo sh ./get-docker.sh && \
     sudo usermod -aG docker $USER && \
     rm ./get-docker.sh && \
     newgrp docker && \
     echo "try docker run hello-world"
}

install_brave () {
    echo "install brave"
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list && \
    sudo apt update && sudo apt install brave-browser -y
}

install_i3wm () {
    echo "install i3"
    bash "$HOME"/.aliases/i3/install.sh

    echo "install fonts"
    bash "$HOME"/.aliases/fonts/install.sh

    echo "install moc (music on console)"
    bash "$HOME"/.aliases/moc/install.sh

    echo "install kitty"
    bash "$HOME"/.aliases/terminal/kitty/install.sh

    install_brave
}

install_tmux() {
    echo "install tmux"
    bash "$HOME"/.aliases/tmux/install.sh
}

install_vim () {
    echo "install vim"
    bash "$HOME"/.aliases/vim/install.sh
}

install_neovim () {
    echo "install neovim"
    bash "$HOME"/.aliases/nvim/install.sh
}

install_omz () {
    echo "install oh-my-zsh"
    bash "$HOME"/.aliases/oh-my-zsh/install.sh
}

install_mail () {
    ## install email server and email reader
    echo "install mail"
    DEBIAN_FRONTEND=noninteractive sudo apt install postfix mutt -y
}

usage () {
    echo -e "
     options:
      --aliases\tinstall aliases (shorthands and functions)
      --mail\tinstall postfix (to recive mail) and mutt (to read)
      --utils\tinstall utils tools (ncdu, shellcheck, exa, fzf, bat, glow, dialog, fetch) and add alias moderns tools to substitute classical tools
      --tmux\tinstall tmux and configure
      --vim\tinstall and set a simple config (without plugins)
      --docker\tinstall docker-ce (using https://get.docker.com script)
      --brave\tinstall add repo (release channel) and install brave-browser
      --i3wm\tinstall i3wm, i3status, rofi, feh, pulseaudio, libnotify-bin, gnome-screenshot and configure them
      --neovim\tdownload, compile and install neovim and configure
      --omz\tinstall omz, add autosuggestions plugin and set a minimalist theme
      --all_env\tinstall all (except mail)

      desktop use:
      ./install.sh --all_env

      without gui use:
      ./install.sh --aliases --utils --vim --mail --docker
    "
}

while test $# -gt 0
do
    case "$1" in
        --aliases)
            install_aliases
        ;;
        --mail)
            install_mail
        ;;
        --utils)
            install_utils
        ;;
        --docker)
            install_docker
        ;;
        --brave)
            install_brave
        ;;
        --i3wm)
            install_i3wm
        ;;
        --tmux)
            install_tmux
        ;;
        --vim)
            install_vim
        ;;
        --neovim)
            install_neovim
        ;;
        --omz)
            install_omz
        ;;
        --all_env)
            install_aliases
            install_utils
            install_tmux
            install_vim
            install_docker
            install_brave
            install_i3wm
            install_neovim
            install_omz
        ;;
        --help)
            usage
        ;;
    esac
    shift
done


