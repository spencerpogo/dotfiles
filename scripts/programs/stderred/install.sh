#!/bin/bash

DIR=$HOME/.stderred

if [ ! -d $DIR ]; then
  log "Installing stderred..."
  git clone --depth 1 https://github.com/sickill/stderred.git "$DIR"
  oldcwd=$(pwd)
  cd "$DIR"
  make
  cd "$oldcwd"
fi
