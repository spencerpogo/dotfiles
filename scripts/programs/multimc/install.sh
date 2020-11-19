#!/bin/bash

if [ ! -d ~/.local/share/multimc ]; then
  echo "Installing multimc..."
  wget -O ~/Downloads/multimc.deb https://files.multimc.org/downloads/multimc_1.4-1.deb
  aptinst multimc.deb
  rm ~/Downloads/multimc.deb
fi
