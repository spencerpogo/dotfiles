#!/bin/bash

if [ ! $(command -v steam) ]; then
  echo "Installing steam..."
  wget -O ~/Downloads/steam.deb https://steamcdn-a.akamaihd.net/client/installer/steam.deb
  aptinst ~/Downloads/steam.deb
  rm ~/Downloads/steam.deb
fi
