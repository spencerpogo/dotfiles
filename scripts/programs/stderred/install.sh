#!/bin/bash

DIR=$HOME/.stderred

if [ ! -d $DIR ]; then
  git clone https://github.com/sickill/stderred.git "$DIR"
  oldcwd=$(pwd)
  cd "$DIR"
  make
  cd "$oldcwd"
fi
