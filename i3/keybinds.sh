#!/bin/bash

CONFIG="${I3_CONFIG:-$HOME/.config/i3/config}"
[[ -r "$CONFIG" ]] || CONFIG="$HOME/.aliases/i3/i3/config"

if [[ ! -r "$CONFIG" ]]; then
  notify-send "i3 keybinds" "config not found"
  exit 1
fi

declare -A vars=()

while IFS= read -r line; do
  if [[ $line =~ ^[[:space:]]*set[[:space:]]+\$([A-Za-z0-9_]+)[[:space:]]+(.+)$ ]]; then
    vars["${BASH_REMATCH[1]}"]="${BASH_REMATCH[2]}"
  fi
done <"$CONFIG"

expand_vars() {
  local value="$1" name repl
  local i=0

  while [[ $value =~ \$([A-Za-z0-9_]+) ]] && ((i++ < 20)); do
    name="${BASH_REMATCH[1]}"
    [[ -n ${vars[$name]+x} ]] || break
    repl="${vars[$name]//&/\\&}"
    value="${value//"\$$name"/$repl}"
  done

  printf '%s' "$value"
}

declare -a rows=()
current_mode=""
last_mode=""

while IFS= read -r line; do
  if [[ $line =~ ^[[:space:]]*mode[[:space:]]+\"([^\"]+)\"[[:space:]]*\{ ]]; then
    current_mode="${BASH_REMATCH[1]}"
    continue
  fi

  if [[ $line =~ ^[[:space:]]*\} ]]; then
    current_mode=""
    continue
  fi

  if [[ $line =~ ^[[:space:]]*bindsym[[:space:]]+((--[A-Za-z-]+[[:space:]]+)*)([^[:space:]]+)[[:space:]]+(.+)$ ]]; then
    keys="$(expand_vars "${BASH_REMATCH[3]}")"
    cmd="$(expand_vars "${BASH_REMATCH[4]}")"

    keys="${keys//Mod4/Super}"
    keys="${keys//Mod1/Alt}"
    cmd="${cmd#exec --no-startup-id }"
    cmd="${cmd#exec }"
    cmd="${cmd//\"/}"

    if [[ $current_mode != "$last_mode" ]]; then
      [[ -n $current_mode ]] && rows+=("── modo $current_mode ──")
      [[ -n $last_mode ]] && rows+=("── modo padrão ──")
      last_mode="$current_mode"
    fi

    rows+=("$(printf '%-26s %s' "$keys" "$cmd")")
  fi
done <"$CONFIG"

if [[ ${1:-} == "--print" ]]; then
  printf '%s\n' "${rows[@]}"
  exit 0
fi

printf '%s\n' "${rows[@]}" |
  rofi -dmenu -i -no-custom -p "i3 keybinds" \
    -mesg "Super+Shift+/ · Esc para fechar" \
    -l 30 >/dev/null
