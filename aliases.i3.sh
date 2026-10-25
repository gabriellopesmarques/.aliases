#########################
##   Aliases i3wm/Xorg ##
#########################

# This file contains aliases and functions specific to i3wm/Xorg
# Loaded only when running on X11

alias togglekbl="~/.aliases/i3/toggle-kbl.sh"
alias ic="vim ~/.aliases/i3/i3/config"
alias ik="~/.aliases/i3/keybinds.sh"

cc() {
  if [[ -f "$1" ]]; then
    xclip -sel clip "$1"
    echo "Copied '$1' to clipboard"
  else
    echo "File '$1' not found"
    return 1
  fi
}

# usage: lorem {?int sentences}
lorem() {
  local sentences="${1:-3}"
  curl -s "http://metaphorpsum.com/sentences/${sentences}" | xclip -i -sel clipboard
  echo 'the text below is in your clipboard:'
  xclip -o -sel clip
}

rememberme() {
  INTERVAL="${2:-1 minutes}"
  # sudo apt install libnotify-bin at -y
  echo "notify-send '» remember' \"$1\"" | at now + "$INTERVAL"
}

tmux_copy_buffer() {
  tmux save-buffer - | xclip -i -sel clipboard
}

