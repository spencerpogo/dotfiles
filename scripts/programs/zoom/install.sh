#!/bin/bash

if [ ! $(needpkg zoom) ]; then
  log "Installing zoom..."
  wget -O ~/Downloads/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
  aptinst ~/Downloads/zoom.deb
  rm ~/Downloads/zoom.deb
fi
