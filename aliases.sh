#########################
##    Aliases v1.78    ##
#########################

# add current directory on path
PATH=.:$PATH
HISTCONTROL=ignoreboth # ignore spaces and duplicated commands (ignorespace, ignoredups)

# load environment variables
vars="$HOME/.aliases/env.sh"
if [[ -f "$vars" ]]; then
  # shellcheck source=/dev/null
  source "$vars"
fi

# packages management

alias alias_update="cd ~/.aliases && git_update && cd -"

install() {
  sudo apt update && sudo apt install "$1" -y
}

update() {
  sudo apt update && sudo apt upgrade

  dry_output="$(sudo apt autoremove --dry-run 2>/dev/null)"

  if grep -q "packages will be REMOVED" <<<"$dry_output"; then
    sudo apt autoremove
  fi
}

uninstall() {
  sudo apt purge "$1"
}

# the command does not always have the same package name
# this help find
pkg_command() {
  dpkg -L "$1" | grep 'bin/'
}

command_comes_from() {
  local real_cmd
  real_cmd="$(command -v "$1")"

  if [[ ! -x "$real_cmd" || ! -f "$real_cmd" ]]; then
    type "$1"
    return 1
  fi

  dpkg -S "$real_cmd"
}

alias UPDATE="alias_update; update; omz update;"

# default args
alias l='ls -lhF'
alias ll='ls -lAhF'
alias lsa='ls -AF'
alias lsat='ls -lhAFt' # sort by modification time, newest first
alias less='less -I'
alias ping="ping -c 10"
alias rsync="rsync --progress"
alias lsblk="lsblk -f"

# cd aliases
alias downloads="cd ~/Downloads; l"
alias dl="downloads"
alias workspace='cd ~/Projects/; clear; pwd; l'
alias ws=workspace
alias wd='cd $WORK_DIR; clear; pwd; l'
alias aliases="cd ~/.aliases"

## config files
alias vimconfig="vim ~/.aliases/vim/vimrc"
alias vc=vimconfig
alias ac="vim ~/.aliases/aliases.sh"
alias zc="vim ~/.zshrc"
alias ic="vim ~/.aliases/i3/i3/config"
alias ec="vim ~/.aliases/env.sh"

####
# shorthands
####################
alias reload="source ~/.zshrc"
alias rank="sort | uniq -c | sort -nr"
alias du_by_size="du -sh ./* | sort -rh"
alias weather="curl https://wttr.in/\?format\=1"
alias togglekbl="~/.aliases/i3/toggle-kbl.sh"
alias cdf='cd $(find -type d 2>/dev/null | fzf)'
alias find_directory=cdf

find_file() {
  fzf --preview 'batcat --style=numbers --theme="TokyoNordStorm" --color=always --line-range=:500 {}'
}

find_package() {
  apt-cache search "$1" | fzf --exact
}

ccd() {
  cd "$1" && clear && ls -lA
}

mkcd() {
  if [ -d "$1" ]; then
    echo "error to create directory \"$1\", directory already exists"
    return 1
  fi

  mkdir "$1"
  cd "$1" || exit

  return 0
}

cc() {
  xclip -sel clip "$1"
}

calc() {
  # requires bc
  echo "scale=2; $1" | bc -q
}

str2md5() {
  echo -n "$1" | md5sum
}

ip_info() {
  curl -q "http://ipwho.is/$1"
}

# usage: lorem {?int sentences}
lorem() {
  curl -s "http://metaphorpsum.com/sentences/${1-3}" | xclip -i -sel clipboard
  echo 'the text below is in your clipboard:'
  xclip -o -sel clip
}

explain() {
  w3m "https://explainshell.com/explain?cmd=$1"
}

help() {
  curl --silent http://cheat.sh/"$1" | less
}

vim_card() {
  curl https://aurelio.net/vim/vimcard.txt
}

rememberme() {
  INTERVAL="${2:-1 minutes}"
  # sudo apt install libnotify-bin at -y
  echo "notify-send '» remember' \"$1\"" | at now + "$INTERVAL"
}

pack() {
  tar -cvzf "pack-$1-$(date '+%Y%m%d%H%M%S').tar.gz" "$1"
}

unpack() {
  tar -xvzf "$1"
}

compress() {
  tar --create --verbose --xz --file "compressed-$1-$(date '+%Y%m%d%H%M%S').tar.xz" "$1"
}

uncompress() {
  tar --extract --verbose --xz --file "$1"
}

download_magnet() {
  # sudo apt install aria2
  if ! [[ $1 =~ "magnet" ]]; then
    echo "arg 1 should be a magnet link"
    return 1
  fi

  aria2c -d ~/Downloads --seed-ratio="2.0" "$1"
}

download_torrent() {
  aria2c -d ~/Downloads --seed-ratio="2.0" --torrent-file="$1"
}

## auto fixing typos
alias dc="cd"
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
alias :q="exit"
alias :Q="exit"

####
# git topcoat
####################
alias s='git status -s'
alias d='git diff'
alias u="git fetch --all --prune && git pull --recurse-submodules --all"
alias log="git log --oneline"

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
    -f | --force)
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
    echo "running: git push --force-with-lease ${args[*]} \n"
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

git_update() {
  # abort if working directory is not clean
  __git_is_clean || return 1

  echo " executing: git fetch origin && git reset --hard FETCH_HEAD" &&
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
  read -r confirm

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

git_delete_branch() {
  git branch -d "$1" &&
    git push origin --delete "$1"
}

####
# tmux
####################
alias tmux="tmux -2"
alias tl="tmux ls"

tmux_dev() {
  SESSION_NAME="$1"
  export WORK_DIR="$2"

  # create session, windows and panels
  tmux new-session -s "$SESSION_NAME" -n editor -d
  tmux set-environment WORK_DIR "$2"
  tmux send-keys -t "$SESSION_NAME" "     cd $WORK_DIR; clear; nvim ." C-m
  tmux new-window -n zsh -t "$SESSION_NAME"
  tmux send-keys -t "$SESSION_NAME" "     cd $WORK_DIR; clear; docker ps" C-m
  tmux split-window -v -t "$SESSION_NAME"
  tmux send-keys -t "$SESSION_NAME" "     cd $WORK_DIR; clear; git status" C-m

  tmux attach -t "$1"
}

tmux_copy_buffer() {
  tmux save-buffer - | xclip -i -sel clipboard
}

cli() {
  session="cli"

  if ! tmux has-session -t "$session" 2>/dev/null; then
    tmux new-session -s "$session" -d
  fi

  tmux attach-session -t "$session"
}

# always tmux
if command -v tmux &>/dev/null &&
  [[ -n "$PS1" ]] &&
  [[ -z "$TMUX" ]] &&
  [[ "$TERM" = "xterm-256color" ]]; then
  cli
fi

####
# Docker aliases
####################
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"
alias dcd="docker compose down --volumes"
alias dpsa="docker ps -a"
alias di="docker images"
alias dv="docker volume ls"
alias dsdf='docker system df'
alias docker_prune='docker system prune'
alias docker_images_size='docker images --format "{{.ID}}\t{{.Size}}\t{{.Repository}}" | sort -r -k 2 -h'

dps() {
  docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}'
}

dpsw() {
  docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Label "com.docker.compose.project.working_dir"}}'
}

docker_kill_all() {
  docker rm -f "$(docker ps -q)"
}

## containered services
alias simple_server='python3 -m http.server 9000'
alias static_server='docker run --name "$(basename "$(pwd)")_static_server" -p 80:80 -v "$(pwd):/usr/share/nginx/html" -d nginx'
alias php56_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:5.6-apache'
alias php71_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.1-apache'
alias php72_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:7.2-apache'
alias php80_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:8.0-apache'
alias php82_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php:8.2-apache'
alias php80_dev_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php-dev:8.0-apache'
alias php82_dev_server='docker run --name "$(basename "$(pwd)")_chialab" -p 80:80 -v "$PWD":/var/www/html/ -d chialab/php-dev:8.2-apache'
alias speedtest='docker run --rm --dns="1.1.1.1" -it gists/speedtest-cli'
alias psysh='docker run --rm --interactive --tty --volume $PWD:/app psysh:latest'

php() {
  docker run --rm --interactive --tty --name php-script --volume "$PWD":/app --workdir /app --user "$(id -u):$(id -g)" php:8.4-cli php "$@"
}

composer() {
  docker run --rm --interactive --tty --volume "$PWD":/app --user "$(id -u):$(id -g)" composer "$@"
}

trans() {
  docker run --rm --interactive --tty soimort/translate-shell "$@"
}

restore_permissions() {
  if [ $# -ne 1 ]; then
    echo "use: restore_permissions <directory>"
    return 1
  fi

  dir=$1

  if [ ! -d "$dir" ]; then
    echo "Erro: '$dir' is not a valid directory"
    return 1
  fi

  sudo find "$dir" -type d -exec chmod 755 {} \;
  sudo find "$dir" -type f -exec chmod 644 {} \;
  echo "done"
}

cat_from_url() {
  if [[ $# -ne 1 ]]; then
    echo "use: cat_from_url <url>"
    return 1
  fi

  local url="$1"

  local has_wget=0
  local has_curl=0

  command -v wget &>/dev/null && has_wget=1
  command -v curl &>/dev/null && has_curl=1

  if ((!has_wget && !has_curl)); then
    echo "ERROR: curl or wget is required"
    return 127
  fi

  if ((has_wget)); then
    wget -qO - "$url"
    return $?
  fi

  if ((has_curl)); then
    curl -sL "$url"
    return $?
  fi
}

echo "[ $(whoami) ]"
