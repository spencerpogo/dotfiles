#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

gnome-extensions show dash-to-panel@jderose9.github.com >/dev/null
if [ $? -ne 0 ]; then
  echo "Installing dash-to-panel..."
  git clone https://github.com/home-sweet-gnome/dash-to-panel.git panel
  cd panel && make install
  cd ..
  rm -rf panel
  gnome-extensions enable dash-to-panel
fi
