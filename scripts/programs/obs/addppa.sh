#!/bin/bash

if [ ! -f "/etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-$(lsb_release -cs).list" ]; then
  log "Adding OBS PPA..."
  sudo add-apt-repository -yn ppa:obsproject/obs-studio
fi
