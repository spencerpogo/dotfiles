#!/bin/bash

if [ ! $(command -v steam) ]; then
  log "Installing steam..."
  instdeb steam https://steamcdn-a.akamaihd.net/client/installer/steam.deb
fi
