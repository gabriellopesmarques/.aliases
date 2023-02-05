#########################
##    Aliases v1.34    ##
#########################

# add current directory on path
PATH=.:$PATH
HISTCONTROL=ignoreboth # ignore spaces and duplicated commands (ignorespace, ignoredups)

# aliases for repo
alias aliases="cd ~/.aliases"
alias alias_update="cd ~/.aliases && git pull && cd -"

# Utils Short Commands
alias l='ls -lhF'
alias ll='ls -lAhF'
alias lsa='ls -AF'
alias lsat='ls -lhAFt' # sort by modification time, newest first
alias s='git status'
alias u="git fetch --all --prune && git pull --all"
alias a='git add .'
alias c='git commit -m $1'
alias ac='git commit -a -m $1'
alias b='git branch -a'
alias co='git checkout $1'
alias clears='clear; git status'
alias rank="sort | uniq -c | sort -nr"
alias downloads="cd ~/Downloads; l"
alias dl="downloads"
alias workspace='cd ~/Projects/; l'
alias ws=workspace
alias wd="cd $WORK_DIR"
alias :q="exit"
alias :Q="exit"
alias vimconfig="vim ~/.aliases/vim/vimrc"
alias vc=vimconfig
alias ac="vim ~/.aliases/aliases.sh"
alias zc="vim ~/.zshrc"
alias ic="vim ~/.aliases/i3/i3.conf"
alias tmux="tmux -2"
alias tl="tmux ls"
alias reload="source ~/.zshrc"
alias dc="cd"
alias UPDATE="alias_update; update; omz update;"

alias weather="curl https://wttr.in/\?format\=1"
alias togglekbl="~/.aliases/i3/toggle-kbl.sh"
alias calendar="dialog --calendar 'calendar' 0 0"

# dummy ways to write clear
alias claer=clear
alias cl='clear; ls'
alias cll='clear; ls -lA'
alias ckear=clear
alias clearl='clear; ls'
alias lear=clear
alias ear=clear
alias cear=clear
alias cçear=clear
alias limpar=clear
alias limpa=clear
alias clea=clear
alias rl="clear & ls -la"


# check if bat is installed
if command -v batcat &> /dev/null
then
    alias bat="batcat"
fi

calc () {
    # requires bc
    echo "scale=2; $1" | bc -q
}

delete_branch(){
    git branch -d $1 && \
    git push origin --delete $1
}

cc(){
    xclip -sel clip $1
}

download_magnet(){
    # sudo apt-get install aria2
    if ! [[ $1 =~ "magnet" ]]; then
        echo "arg 1 should be a magnet link"
        return 1;
    fi

    aria2c -d ~/Downloads --seed-ratio="2.0" $1
}

download_torrent(){
    aria2c -d ~/Downloads --seed-ratio="2.0" --torrent-file=$1
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

update(){
    sudo apt-get update && sudo apt-get upgrade
}

uninstall() {
    sudo apt-get purge $1
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

explain(){
    w3m "https://explainshell.com/explain?cmd=$1"
}

pack(){
    tar -cvzf pack-$1-$(date '+%Y%m%d%H%M%S').tar.gz $1
}

unpack(){
    tar -xvzf $1
}

rememberme(){
    INTERVAL="${2:-1 minutes}"
    # sudo apt-get install libnotify-bin at -y
    echo "notify-send '» remember' \"$1\"" | at now + $INTERVAL
}

composer(){
    docker run --rm --interactive --tty --volume $PWD:/app --user $(id -u):$(id -g) composer $@
}

cli(){
    session="cli"
    tmux has-session -t $session 2>/dev/null

    if [ $? != 0 ]; then
        tmux new-session -s 'cli'
    fi

    tmux attach-session -t $session
}

tmux_dev(){
    SESSION_NAME=$1
    export WORK_DIR=$2

    # create session, windows and panels
    tmux new-session -s $SESSION_NAME -n editor -d 
    tmux send-keys -t $SESSION_NAME "     cd $WORK_DIR; clear; vim ." C-m
    tmux new-window -n zsh -t $SESSION_NAME
    tmux send-keys -t $SESSION_NAME "     cd $WORK_DIR; clear; docker ps" C-m
    tmux split-window -v -t $SESSION_NAME
    tmux send-keys -t $SESSION_NAME "     cd $WORK_DIR; clear; git status" C-m

    tmux attach -t $1
}

tmux_copy_buffer(){
    tmux save-buffer - | xclip -i -sel clipboard
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
alias di="docker images"
alias dv="docker volume ls"
alias docker_images_size='docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}" | sort -r -k 2 -h'

# fast services
alias static_server='docker run --name "$(basename $(pwd))_static_server" -p 80:80 -v "$(pwd):/usr/share/nginx/html" -d nginx'
alias php56_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:5.6-apache'
alias php71_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.1-apache'
alias php72_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.2-apache'
alias php80_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:8.0-apache'

####
# Gnome
####################
open() {
    nautilus --new-window $1 > /dev/null 2>&1 &
}

echo "[ $(whoami) ]"

