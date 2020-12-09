#!/bin/bash

if [ ! -f "/etc/apt/sources.list.d/inkscape_dev-ubuntu-stable-$(lsb_release -cs).list" ]; then
  log "Adding inkscape PPA..."
  addrepo -yn ppa:inkscape.dev/stable
fi
