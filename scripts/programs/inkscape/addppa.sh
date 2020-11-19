#!/bin/bash

if [ ! -f "/etc/apt/sources.list.d/inkscape_dev-ubuntu-stable-$(lsb_release -cs).list" ]; then
  echo "Adding inkscape PPA..."
  sudo add-apt-repository -yn ppa:inkscape.dev/stable
fi
