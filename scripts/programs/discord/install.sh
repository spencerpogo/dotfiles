#!/bin/bash

set -e

if [ ! $(command -v discord) ]; then 
  echo "Installing discord..."
  wget -O ~/Downloads/discord.deb https://discord.com/api/download\?platform\=linux\&format\=deb
  sudo apt install ~/Downloads/discord.deb
  rm -f ~/Downloads/discord.deb
fi
