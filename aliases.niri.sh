############################
##  Aliases niri/Wayland  ##
############################

# This file contains aliases and functions specific to niri/Wayland
# Loaded only when running on Wayland

alias nc="vim ~/.config/niri/config.kdl"

cc() {
  if [[ -f "$1" ]]; then
    wl-copy <"$1"
    echo "Copied '$1' to clipboard"
  else
    echo "File '$1' not found"
    return 1
  fi
}

# usage: lorem {?int sentences}
lorem() {
  local sentences="${1:-3}"
  curl -s "http://metaphorpsum.com/sentences/${sentences}" | wl-copy
  echo 'the text below is in your clipboard:'
  wl-paste
}

rememberme() {
  INTERVAL="${2:-1 minutes}"
  # Works on Wayland (requires notification daemon: swaync/mako)
  echo "notify-send '» remember' \"$1\"" | at now + "$INTERVAL"
}

tmux_copy_buffer() {
  tmux save-buffer - | wl-copy
}

