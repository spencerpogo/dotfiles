#!/bin/bash

if [ $(needpkg discord) ]; then 
  log "Installing discord..."
  instdeb discord https://discord.com/api/download\?platform\=linux\&format\=deb
fi
