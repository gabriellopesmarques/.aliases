#########################
##    Aliases v1.0     ##
#########################

# Utils Short Commands
alias s='git status'
alias a='git add .'
alias c='git commit -m $1'
alias ac='git commit -a -m $1'
alias b='git branch -a'
alias co='git checkout $1'
alias clears='clear; git status'
alias workspace='cd ~/Projects/'
alias ws=workspace
alias static_server='docker run --name "$(basename $(pwd))_static_server" -p 80:80 -v "$(pwd):/usr/share/nginx/html" -d nginx'
alias php56_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:5.6-apache'
alias php71_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.1-apache'
alias php72_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.2-apache'

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

ccd() {
    cd $1 && clear && ls -lA;
} 

mkcd() {
    if [ ! -d "$1" ]; then
        mkdir $1; cd $1;
        echo "directory created successfully, you are here $(pwd) now"
        return true
    fi

    echo "error to create directory \"$1\", directory already exists"
    return false
} 

help(){
    wget -qO- http://cheat.sh/$1 | less
}

####
# Docker aliases
####################

dps(){
    echo "NAME|IMAGE|PORTS" | cat - <(docker ps --format "{{.Names}}|{{.Image}}|{{.Ports}}\n") | column -t -s "|"
}

alias dcu="docker-compose up -d --build"
alias dcd="docker-compose down"

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