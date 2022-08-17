#########################
##    Aliases v1.20    ##
#########################

# add current directory on path
PATH=.:$PATH

# aliases for repo
alias alias_update="cd ~/.aliases && git pull && cd -"

# Utils Short Commands
alias l='ls -lhAF'
alias lsa='ls -AF'
alias lsat='ls -lhAFt' # sort by modification time, newest first
alias s='git status'
alias a='git add .'
alias c='git commit -m $1'
alias ac='git commit -a -m $1'
alias b='git branch -a'
alias co='git checkout $1'
alias clears='clear; git status'
alias rank="sort | uniq -c | sort -nr"
alias downloads="cd ~/Downloads"
alias dl="downloads"
alias workspace='cd ~/Projects/'
alias ws=workspace
alias :q="exit"
alias :Q="exit"
alias vimconfig="vim ~/.aliases/vimrc"
alias vc=vimconfig
alias vim_install="vim +PlugInstall +qall"
alias tmux="tmux -2"
alias ae="vim ~/.aliases/aliases.sh"
alias static_server='docker run --name "$(basename $(pwd))_static_server" -p 80:80 -v "$(pwd):/usr/share/nginx/html" -d nginx'
alias php56_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:5.6-apache'
alias php71_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.1-apache'
alias php72_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.2-apache'
alias php80_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:8.0-apache'

# dummy ways to write clear
alias claer=clear
alias cl='clear && ls'
alias cll='clear && ls -lA'
alias ckear=clear
alias clearl='clear && ls'
alias lear=clear
alias ear=clear
alias cear=clear
alias cçear=clear
alias limpar=clear
alias limpa=clear
alias clea=clear
alias rl="clear & ls -la"
alias osls="hostnamectl"


# check if bat is installed
if command -v batcat &> /dev/null
then
    alias bat="batcat"
fi

delete_branch(){
    git branch -d $1 && \
    git push origin --delete $1
}

cc(){
    xclip -sel clip $1
}

import_shortcuts(){
    ~/.aliases/keybinding-gnome.pl -i ~/.aliases/gnome-shortcuts.conf
}

export_shortcuts(){
    ~/.aliases/keybinding-gnome.pl -e ~/.aliases/gnome-shortcuts.conf && \
    echo "successfully exported! :D"
}

dumpMongo() {
    PATH_TO_DUMP="$HOME/dumps/"

    if [ -z "$1" ] ; then
        echo "Please set a database to dump"
        return;
    else
        DATABASE=$1
    fi

    echo "dumping: $DATABASE"

    if [ ! -d "$PATH_TO_DUMP" ]; then
        mkdir $PATH_TO_DUMP;
    fi

    DIR="$PATH_TO_DUMP$DATABASE-$(date +%Y-%m-%d-%H-%M-%S)"

    mongodump --db $DATABASE --out $DIR

    echo "dumped in $DIR"
}

md5(){
    echo -n $1 | md5sum
}

install() {
    sudo apt-get update && sudo apt-get install $1 -y
}

uninstall() {
    sudo apt-get remove $1 -y && sudo apt-get purge $1
}

ccd() {
    cd $1 && clear && ls -lA;
} 

mkcd() {
    if [ ! -d "$1" ]; then
        mkdir $1; cd $1;
        echo "directory created successfully, you are in $(pwd) now"
        return true
    fi

    echo "error to create directory \"$1\", directory already exists"
    return false
} 

storage(){
    df -h | head -n 1              # head
    df -h | grep -E -i "\/dev\/sd" # storages
}

help(){
    wget -qO- http://cheat.sh/$1 | less
}

pack(){
    tar -czf pack-$(date '+%Y%m%d%H%M%S').tar.gz $1
}

unpack(){
    tar -xzf $1
}

rememberme(){
    INTERVAL="${2:-1 minutes}"
    echo "notify-send '» remember' \"$1\"" | at now + $INTERVAL
}

composer(){
    docker run --rm --interactive --tty --volume $PWD:/app --user $(id -u):$(id -g) composer $@
} 

####
# Docker aliases
####################

dps(){
    echo "NAME|IMAGE|PORTS" | cat - <(docker ps --format "{{.Names}}|{{.Image}}|{{.Ports}}\n") | column -t -s "|"
}

alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"
alias dcd="docker compose down"
alias dpsa="docker ps -a"

####
# Linux
####################
# alias ar='sudo service apache2 restart'

# Switch PHP
# alias php56='sudo a2dismod php5.6; sudo a2dismod php7.1; sudo a2dismod php7.2; sudo a2dismod php7.0; sudo a2enmod php5.6; sudo service apache2 restart; sudo update-alternatives --set php /usr/bin/php5.6; clear; php -v;'
# alias php70='sudo a2dismod php5.6; sudo a2dismod php7.1; sudo a2dismod php7.2; sudo a2dismod php7.0; sudo a2enmod php7.0; sudo service apache2 restart; sudo update-alternatives --set php /usr/bin/php7.0; clear; php -v;'
# alias php71='sudo a2dismod php5.6; sudo a2dismod php7.1; sudo a2dismod php7.2; sudo a2dismod php7.0; sudo a2enmod php7.1; sudo service apache2 restart; sudo update-alternatives --set php /usr/bin/php7.1; clear; php -v;'
# alias php72='sudo a2dismod php5.6; sudo a2dismod php7.1; sudo a2dismod php7.2; sudo a2dismod php7.0; sudo a2enmod php7.2; sudo service apache2 restart; sudo update-alternatives --set php /usr/bin/php7.2; clear; php -v;'

## XFCE open WM
# open() {
#     thunar $1 > /dev/null 2>&1 &
# }

# GNOME open WM
open() {
    nautilus --new-window $1 > /dev/null 2>&1 &
}

####
# macOs
####################
# alias mysql=/usr/local/mysql/bin/mysql
# alias ar='sudo apachectl restart'


echo "[ $(whoami) ]"

