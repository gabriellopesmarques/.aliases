#!/bin/bash

sudo apt update &&
  sudo apt install mycli pgcli &&
  echo "source ~/.aliases/packages/db-client/dbcli.sh" >>"$HOME"/.zshrc
