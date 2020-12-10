#!/bin/bash

if [ ! $(needpkg zoom) ]; then
  log "Installing zoom..."
  instdeb zoom https://zoom.us/client/latest/zoom_amd64.deb
fi
