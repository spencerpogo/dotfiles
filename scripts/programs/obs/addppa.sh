#!/bin/bash

if [ $(needpkg obs-studio) ]; then
  log "Adding OBS PPA..."
  addrepo obs "deb http://ppa.launchpad.net/obsproject/obs-studio/ubuntu $(codename) main"
fi
