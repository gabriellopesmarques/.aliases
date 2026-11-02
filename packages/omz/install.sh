#!/bin/bash

## install zsh
sudo apt install git curl zsh -y

## install oh my zsh (batch-mode)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## install autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

## install zsh-syntax-highlighting autosuggestions plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

## in this way, each user can get your own aliases too. edit file with: zc
echo "source ~/.aliases/packages/omz/config" >"$HOME"/.zshrc

## custom theme
src="$HOME/.aliases/packages/omz/themes/x.zsh-theme"
dst="$HOME/.oh-my-zsh/custom/themes/x.zsh-theme"

if [[ -e "$dst" && ! -L "$dst" ]]; then
  printf 'error: %s exists and is not a symlink\n' "$dst" >&2
  exit 1
fi

mkdir -p "$(dirname -- "$dst")"
ln -sfn "$src" "$dst"

## set zsh as default shell
sudo chsh "$USER" --shell "$(command -v zsh)"
