#!/bin/bash

if [ ! -f /etc/apt/sources.list.d/inkscape_dev-ubuntu-stable-focal.list ]; then
  sudo add-apt-repository -n ppa:inkscape.dev/stable
fi
