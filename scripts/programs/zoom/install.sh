#!/bin/bash

if [ ! $(command -v zoom) ]; then
  wget -O ~/Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install ~/Downloads/zoom.deb
  rm ~/Downloads/zoom.deb
fi
