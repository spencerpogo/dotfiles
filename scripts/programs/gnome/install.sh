#!/bin/bash

set +e
gnome-extensions show dash-to-panel@jderose9.github.com >/dev/null
r=$?
set -e

if [ $r -ne 0 ]; then
  log "Installing dash-to-panel..."
  git clone https://github.com/home-sweet-gnome/dash-to-panel.git panel
  cd panel && make install
  cd ..
  rm -rf panel
  gnome-extensions enable dash-to-panel
fi

log "Loading dconf settings..."
dconf load /org/gnome/ < .config/dconf/settings.dconf
log "Restarting gnome..."
killall -SIGQUIT gnome-shell
