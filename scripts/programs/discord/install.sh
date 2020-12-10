#!/bin/bash

if [ ! $(needpkg discord) ]; then 
  log "Installing discord..."
  wget -O ~/Downloads/discord.deb https://discord.com/api/download\?platform\=linux\&format\=deb
  aptinst ~/Downloads/discord.deb
  rm -f ~/Downloads/discord.deb
fi
