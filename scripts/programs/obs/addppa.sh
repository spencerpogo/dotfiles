#!/bin/bash

if [ $(needpkg obs-studio) ]; then
  log "Adding OBS PPA..."
  addrepo ppa:obsproject/obs-studio
fi
