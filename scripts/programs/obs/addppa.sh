#!/bin/bash

if [ $(needspkg obs-studio) ]; then
  log "Adding OBS PPA..."
  addrepo ppa:obsproject/obs-studio
fi
