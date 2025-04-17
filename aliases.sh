#########################
##    Aliases v1.69    ##
#########################

# add current directory on path
PATH=.:$PATH
HISTCONTROL=ignoreboth # ignore spaces and duplicated commands (ignorespace, ignoredups)


# load environment variables
vars=$HOME/.aliases/env.sh
if [ -f "$vars" ]; then
    source "$vars"
fi

# aliases for repo
alias aliases="cd ~/.aliases"
alias alias_update="cd ~/.aliases && git pull && cd -"

update_aliases(){
    if [[ -f $HOME/.aliases.sh ]]; then
        wget https://raw.githubusercontent.com/gabriellopesmarques/.aliases/main/aliases.sh -O $HOME/.aliases.sh
    else
        git -C $HOME/.aliases pull
    fi
}

# Utils Short Commands
alias l='ls -lhF'
alias ll='ls -lAhF'
alias lsa='ls -AF'
alias lsat='ls -lhAFt' # sort by modification time, newest first
alias less='less -I'
alias s='git status -s'
alias d='git diff'
alias u="git fetch --all --prune && git pull --recurse-submodules --all"
alias log="git log --oneline --graph"
alias clears='clear; git status'
alias rank="sort | uniq -c | sort -nr"
alias downloads="cd ~/Downloads; l"
alias dl="downloads"
alias workspace='cd ~/Projects/; clear; pwd; l'
alias ws=workspace
alias wd="cd $WORK_DIR; clear; pwd; l"
alias :q="exit"
alias :Q="exit"
alias vimconfig="vim ~/.aliases/vim/vimrc"
alias vc=vimconfig
alias ac="vim ~/.aliases/aliases.sh"
alias zc="vim ~/.zshrc"
alias ic="vim ~/.aliases/i3/i3.conf"
alias ec="vim ~/.aliases/env.sh"
alias tmux="tmux -2"
alias tl="tmux ls"
alias reload="source ~/.zshrc"
alias dc="cd"
alias cdf='cd $(find -type d 2>/dev/null | fzf)'
alias ping="ping -c 10"
alias rsync="rsync --progress"
alias lsblk="lsblk -f"
alias UPDATE="alias_update; update; omz update;"

alias weather="curl https://wttr.in/\?format\=1"
alias speedtest='docker run --rm --dns="1.1.1.1" -it gists/speedtest-cli'
alias togglekbl="~/.aliases/i3/toggle-kbl.sh"

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

####
# git topcoat
####################

git() {
  if [[ "$1" != "push" ]]; then
    command git "$@"
    return
  fi

  local args=()
  local force_detected=false

  for arg in "${@:2}"; do
    case "$arg" in
      --force-with-lease)
        command git "$@"
        return
        ;;
      -f|--force)
        force_detected=true
        ;;
      *)
        args+=("$arg")
        ;;
    esac
  done

  if $force_detected; then
    echo "\n -- !! intercepted command !! -- \n"
    echo "hey, easy there!"
    echo "push force, really?! and without a leash? let's play it safe"
    echo "running: git push --force-with-lease ${args[@]} \n"
    command git push --force-with-lease "${args[@]}"
    return
  fi

  command git "$@"
}

__git_is_clean() {
  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "working directory is not clean. please commit or stash your changes before proceeding."
    return 1
  fi

  return 0
}

git_update(){
  # abort if working directory is not clean
  __git_is_clean || return 1

  echo " executing: git fetch origin && git reset --hard FETCH_HEAD" && \
  git fetch origin && git reset --hard FETCH_HEAD
}

git_clean_branches() {
  echo "fetching and pruning remotes..."
  git fetch -p

  # capture local branches marked as ': gone]'
  local branches_to_delete
  branches_to_delete=$(git branch -vv | grep '\[.*: gone]' | awk '{if ($1 == "*") print $2; else print $1}')

  if [[ -z "$branches_to_delete" ]]; then
    echo "no obsolete branches found"
    return
  fi

  echo "the following branches will be deleted:"
  echo "$branches_to_delete"

  printf "\ndo you want to proceed with deleting these branches? [y/N]: "
  read confirm

  if [[ "$confirm" =~ ^[yY](es)?$ ]]; then
    echo "deleting branches..."
    printf "%s\n" "$branches_to_delete" | while IFS= read -r branch; do
        git branch -D "$branch"
    done
    echo "cleanup completed"
  fi
}

git_sync_branches() {
  # use default branches if none are provided
  if [[ $# -eq 0 ]]; then
    set -- master develop
  fi

  # abort if working directory is not clean
  __git_is_clean || return 1

  # save the current branch to return to it later
  local current_branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  echo "fetching and pruning remotes..."
  git fetch --all --prune

  # sync each specified branch with its corresponding origin branch
  for branch in "$@"; do
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      echo "updating $branch with reset --hard from origin/$branch..."
      git checkout "$branch" && git reset --hard "origin/$branch"
    else
      echo "branch $branch does not exist locally, skipping..."
    fi
  done

  echo "returning to $current_branch..."
  git checkout "$current_branch"
}



git_delete_branch(){
    git branch -d $1 && \
    git push origin --delete $1
}

calc(){
    # requires bc
    echo "scale=2; $1" | bc -q
}

cc(){
    xclip -sel clip $1
}

download_magnet(){
    # sudo apt install aria2
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
    sudo apt update && sudo apt install $1 -y
}

update(){
    sudo apt update && sudo apt upgrade
}

uninstall() {
    sudo apt purge $1
}

ccd() {
    cd $1 && clear && ls -lA;
} 

mkcd() {
    if [ -d "$1" ]; then
        echo "error to create directory \"$1\", directory already exists"
        return 1
    fi

    mkdir $1; cd $1;
    return 0
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

vim_card(){
    curl https://aurelio.net/vim/vimcard.txt
}

pack(){
    tar -cvzf pack-$1-$(date '+%Y%m%d%H%M%S').tar.gz $1
}

unpack(){
    tar -xvzf $1
}

compress(){
    tar --create --verbose --xz --file compressed-$1-$(date '+%Y%m%d%H%M%S').tar.xz $1
}

uncompress(){
    tar --extract --verbose --xz --file $1
}

ip_info(){
    curl -q http://ipwho.is/$1
}

rememberme(){
    INTERVAL="${2:-1 minutes}"
    # sudo apt install libnotify-bin at -y
    echo "notify-send '» remember' \"$1\"" | at now + $INTERVAL
}


# usage: lorem {?int sentences}
lorem() {
    curl -s http://metaphorpsum.com/sentences/${1-3} | xclip -i -sel clipboard
    echo "\e[0;34m"'the text below is in your clipboard:'"\e[m"
    xclip -o -sel clip
}

php(){
    #docker run -it --rm --name php-script -v "$PWD":/app -w /app php:8.3-cli $@
    docker run --rm --interactive --tty --volume $PWD:/app --workdir /app --user $(id -u):$(id -g) php:8.3-cli php $@
}

composer(){
    docker run --rm --interactive --tty --volume $PWD:/app --user $(id -u):$(id -g) composer $@
}

trans(){
    docker run --rm --interactive --tty soimort/translate-shell $@
}

cli(){
    session="cli"
    tmux has-session -t $session 2>/dev/null

    if [ $? != 0 ]; then
        tmux new-session -s 'cli' -d
    fi

    tmux attach-session -t $session
}

search_file(){
    fzf --preview 'batcat --style=numbers --theme="TokyoNordStorm" --color=always --line-range=:500 {}'
}

tmux_dev(){
    SESSION_NAME=$1
    export WORK_DIR=$2

    # create session, windows and panels
    tmux new-session -s $SESSION_NAME -n editor -d 
    tmux set-environment WORK_DIR $2
    tmux send-keys -t $SESSION_NAME "     cd $WORK_DIR; clear; nvim ." C-m
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
dps () {
    docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}'
}

dpsw () {
    docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Label "com.docker.compose.project.working_dir"}}'
}

docker_kill_all () {
    docker rm -f $(docker ps -q)
}

alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"
alias dcd="docker compose down --volumes"
alias dpsa="docker ps -a"
alias di="docker images"
alias dv="docker volume ls"
alias docker_images_size='docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}" | sort -r -k 2 -h'

# fast services
alias simple_server='python3 -m http.server 9000'
alias static_server='docker run --name "$(basename $(pwd))_static_server" -p 80:80 -v "$(pwd):/usr/share/nginx/html" -d nginx'
alias php56_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:5.6-apache'
alias php71_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.1-apache'
alias php72_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.2-apache'
alias php80_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:8.0-apache'
alias php82_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:8.2-apache'
alias php80_dev_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php-dev:8.0-apache'
alias php82_dev_server='docker run --name "$(basename $(pwd))_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php-dev:8.2-apache'

####
# always tmux
####################
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ "$TERM" = "xterm-256color" ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  cli
fi

echo "[ $(whoami) ]"

