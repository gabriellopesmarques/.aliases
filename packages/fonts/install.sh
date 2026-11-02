#!/bin/bash

## install fonts

sudo mkdir -p /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/Space_Mono/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/victor_mono/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/jetbrains_mono/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/Glass_VT220/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/fira/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/ibm_plex/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/recursive/ /usr/share/fonts/truetype/ &&
  sudo cp -r "$HOME"/.aliases/packages/fonts/google_sans_code/ /usr/share/fonts/truetype/
