#!/bin/bash

dir=$PWD

if [[ $dir != *.aliases/packages/fetch* ]]; then
  dir=$(dirname "$0")
fi

src="$dir/fetch"
dst="/usr/local/bin/fetch"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

sudo ln -sfn "$src" "$dst"
