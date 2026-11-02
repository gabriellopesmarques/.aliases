#!/bin/bash

group_state_file() {
  printf '%s\n' "${XDG_STATE_HOME:-$HOME/.local/state}/shpkg/installed"
}

group_is_installed() {
  local state_file

  state_file="$(group_state_file)"
  [[ -f "$state_file" ]] && grep -qxF -- "$1" "$state_file"
}

group_item_description() {
  local name="$1"
  local info
  local type
  local description

  info="$("$SHPKG_ROOT/shpkg" info "$name")" || return 1
  type="$(sed -n 's/^type:[[:space:]]*//p' <<<"$info")"
  description="$(sed -n 's/^description:[[:space:]]*//p' <<<"$info")"
  [[ "$description" == "-" ]] && description="$type"
  if group_is_installed "$name"; then
    description="$description [installed]"
  fi
  printf '%s' "$description"
}

group_install_all() {
  local group="$1"

  shift
  printf '==> no interactive terminal; installing all packages for %s\n' "$group" >&2
  "$SHPKG_ROOT/shpkg" install "$@"
}

group_select() {
  local group="$1"
  local -a items
  local -a dialog_args=()
  local -a selected=()
  local item
  local description
  local tmp
  local status

  shift
  items=("$@")

  if [[ ! -t 0 || ! -t 1 ]]; then
    group_install_all "$group" "${items[@]}"
    return
  fi

  if ! command -v dialog >/dev/null 2>&1; then
    "$SHPKG_ROOT/shpkg" install --force dialog
  fi
  if ! command -v dialog >/dev/null 2>&1; then
    printf 'error: dialog is not available\n' >&2
    return 1
  fi

  for item in "${items[@]}"; do
    description="$(group_item_description "$item")" || return 1
    dialog_args+=("$item" "$description" "on")
  done

  tmp="$(mktemp)" || return 1
  if dialog --stdout --separate-output \
    --title "Install $group" \
    --ok-label "Install" \
    --cancel-label "Cancel" \
    --checklist "Select packages to install:" 22 78 15 \
    "${dialog_args[@]}" >"$tmp"; then
    mapfile -t selected <"$tmp"
  else
    status=$?
    rm -f "$tmp"
    if [[ "$status" -eq 1 || "$status" -eq 255 ]]; then
      printf '==> installation cancelled\n' >&2
    else
      printf 'error: dialog failed with status %s\n' "$status" >&2
    fi
    return 1
  fi
  rm -f "$tmp"

  if [[ ${#selected[@]} -eq 0 ]]; then
    printf '==> no packages selected\n' >&2
    return 1
  fi

  "$SHPKG_ROOT/shpkg" install "${selected[@]}"
}
