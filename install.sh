#!/bin/bash

install_aliases () {
    echo "installing aliases"
    sudo apt install git zsh htop tree bc lm-sensors aria2 libnotify-bin at w3m xclip -y  # aliases.sh dependencies

    # add aliases in bash
    echo "source ~/.aliases/aliases.sh" >> "$HOME"/.bashrc
    echo "source ~/.aliases/aliases.sh" >> "$HOME"/.zshrc
}

install_utils () {
    echo "installing utils tools"
    sudo apt install ncdu fdupes shellcheck exa fzf jq exfat-fuse smartmontools fio -y

    # if is a laptop, install laptop things
    if [[ -d "/proc/acpi/button/lid" ]]; then
        sudo apt install network-manager acpi brightnessctl -y
    fi

    bash "$HOME"/.aliases/bat/install.sh     && \
    bash "$HOME"/.aliases/sdcv/install.sh    && \
    bash "$HOME"/.aliases/glow/install.sh    && \
    bash "$HOME"/.aliases/gitui/install.sh   && \
    bash "$HOME"/.aliases/dialog/install.sh  && \
    sudo bash "$HOME"/.aliases/fetch/install.sh

    ## load utils aliases
    echo "source ~/.aliases/aliases.utils.sh" >> "$HOME"/.bashrc
    echo "source ~/.aliases/aliases.utils.sh" >> "$HOME"/.zshrc
}

install_tldr () {
    echo "installing tldr"
    bash "$HOME"/.aliases/tldr/install.sh
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

install_warpd () {
    echo "installing warpd"
    bash "$HOME"/.aliases/i3/warpd/install.sh
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
    install_warpd
    install_feh
    set_default_theme

    sudo apt purge xterm -y
}

install_feh () {
    sudo apt install feh -y
    echo "installing feh"
    bash "$HOME"/.aliases/i3/wallpapers/install.sh
    echo -e "#!/bin/sh\nfeh --no-fehbg --bg-fill $HOME/Pictures/Wallpapers/default/deep_blue-jeremy-bishop-DFJahLoBHK4-unsplash.jpg" > "$HOME/.fehbg"
    sudo chmod 754 "$HOME"/.fehbg
}

set_default_theme () {
    bash "$HOME"/.aliases/set_theme.sh --deep_blue
}

set_vim_editor () {
    sudo update-alternatives --set editor /usr/bin/vim.basic
}

set_no_passwd_when_sudo () {
    user=$(logname)
    sudoers_file="/etc/sudoers.d/$user"
    echo "$user ALL=(ALL) NOPASSWD:ALL" | sudo tee "$sudoers_file" > /dev/null
    sudo chmod 0440 "$sudoers_file"
}

install_tmux () {
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

install_emacs () {
    echo "installing emacs"
    bash "$HOME"/.aliases/emacs/install.sh
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
    echo -e '
            ____  _ __     _  ___               _   _ __  ____ 
      ____ |__  || |  \ __| ||_  \  ____  ____ (_) | |  \|_  _|
     |____| _/ / | || ||__  | _|> ||  __||  __|    | || | _||_ 
           |____|\__|_|   |_||___/ |_|   |_|       \__|_||____|

     options:
      --omz\t\tinstall omz, add autosuggestions plugin and set a minimalist theme
      --aliases\t\tinstall aliases (shorthands and functions)
      --utils\t\tinstall utils tools (ncdu, shellcheck, exa, fzf, bat, glow, gitui, dialog, fetch) and add alias moderns tools to substitute classical tools
      --tldr\t\tinstall tldr a collaborative cheatsheets for console commands
      --vim\t\tinstall and set a simple config (without plugins)
      --neovim\t\tdownload, compile, install and configure neovim
      --emacs\t\tinstall and configure emacs
      --tmux\t\tinstall tmux and configure
      --docker\t\tinstall docker-ce (using https://get.docker.com script)
      --mail\t\tinstall postfix (to recive mail) and mutt (to read)
      --i3wm\t\tinstall i3wm, i3status, rofi, feh, pulseaudio, libnotify-bin, gnome-screenshot, fonts, moc, kitty term, firefox, brave and configure them
      --all_env\t\tinstall all (except mail and emacs)
      --light\t\tinstall omz, aliases, utils, tldr, vim, neovim, tmux

      desktop use:
      ./install.sh --all_env

      without gui use:
      ./install.sh --aliases --utils --vim --mail --docker
    '
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
        --tldr)
            install_tldr
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
        --nvim)
            install_neovim
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
        --all_env)
            install_omz
            install_aliases
            set_vim_editor
            set_no_passwd_when_sudo
            install_utils
            install_tldr
            install_tmux
            install_vim
            install_neovim
            install_docker
            install_i3wm
        ;;
        --light)
            install_omz
            install_aliases
            set_vim_editor
            set_no_passwd_when_sudo
            install_utils
            install_tldr
            install_vim
            install_neovim
        ;;
        --help)
            usage
        ;;
    esac
    shift
done


