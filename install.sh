#!/bin/bash

install_aliases () {
    echo "installing aliases"
    sudo apt install git zsh htop tree bc lm-sensors bc aria2 libnotify-bin at w3m -y  # aliases.sh dependencies
    # add aliases in bash
    echo "source ~/.aliases/aliases.sh" >> "$HOME"/.bashrc
}

install_utils () {
    echo "installing utils tools"
    sudo apt install ncdu shellcheck exa fzf jq -y
    #brightnessctl

    bash "$HOME"/.aliases/bat/install.sh     && \
    bash "$HOME"/.aliases/glow/install.sh    && \
    bash "$HOME"/.aliases/gitui/install.sh   && \
    bash "$HOME"/.aliases/dialog/install.sh  && \
    sudo bash "$HOME"/.aliases/fetch/install.sh

    ## load utils aliases
    echo "source ~/.aliases/aliases.utils.sh" >> "$HOME"/.bashrc
    echo "source ~/.aliases/aliases.utils.sh" >> "$HOME"/.zshrc
}

install_docker () {
     echo "installing docker"
     sudo apt install curl -y
     curl -fsSL https://get.docker.com -o get-docker.sh && \
     sudo sh ./get-docker.sh && \
     sudo usermod -aG docker "$USER" && \
     rm ./get-docker.sh && \
     echo "reboot or run 'newgrp docker'"
}

install_brave () {
    echo "installing brave"
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list && \
    sudo apt update && sudo apt install brave-browser -y
}

install_i3wm () {
    echo "installing i3"
    bash "$HOME"/.aliases/i3/install.sh

    echo "install fonts"
    bash "$HOME"/.aliases/fonts/install.sh

    echo "install moc (music on console)"
    bash "$HOME"/.aliases/moc/install.sh

    echo "install kitty"
    bash "$HOME"/.aliases/terminal/kitty/install.sh

    install_brave
    install_gitfiend
}

install_gitfiend() {
    echo "installing git fiend"
    bash "$HOME"/.aliases/gitfiend/install.sh
}

install_tmux() {
    echo "installing tmux"
    bash "$HOME"/.aliases/tmux/install.sh
}

install_vim () {
    echo "installing vim"
    bash "$HOME"/.aliases/vim/install.sh
}

install_neovim () {
    echo "installing neovim"
    bash "$HOME"/.aliases/nvim/install.sh
}

install_omz () {
    echo "installing oh-my-zsh"
    bash "$HOME"/.aliases/oh-my-zsh/install.sh
}

install_mail () {
    ## install email server and email reader
    echo "installing mail"
    DEBIAN_FRONTEND=noninteractive sudo apt install postfix mutt -y
}

usage () {
    echo -e "
     options:
      --omz\tinstall omz, add autosuggestions plugin and set a minimalist theme
      --aliases\tinstall aliases (shorthands and functions)
      --utils\tinstall utils tools (ncdu, shellcheck, exa, fzf, bat, glow, gitui, dialog, fetch) and add alias moderns tools to substitute classical tools
      --vim\tinstall and set a simple config (without plugins)
      --neovim\tdownload, compile and install neovim and configure
      --tmux\tinstall tmux and configure
      --docker\tinstall docker-ce (using https://get.docker.com script)
      --mail\tinstall postfix (to recive mail) and mutt (to read)
      --i3wm\tinstall i3wm, i3status, rofi, feh, pulseaudio, libnotify-bin, gnome-screenshot, fonts, moc, kitty term, firefox, brave and configure them
      --gitfiend\tinstall gitfiend (git gui)
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
        --omz)
            install_omz
        ;;
        --aliases)
            install_aliases
        ;;
        --utils)
            install_utils
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
        --docker)
            install_docker
        ;;
        --mail)
            install_mail
        ;;
        --i3wm)
            install_i3wm
        ;;
        --gitfiend)
            install_gitfiend
        ;;
        --all_env)
            install_omz
            install_aliases
            install_utils
            install_tmux
            install_vim
            install_neovim
            install_docker
            install_i3wm
            install_gitfiend
        ;;
        --help)
            usage
        ;;
    esac
    shift
done


