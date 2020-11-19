#!/bin/bash

# Add flathub repo
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

installflatpak () {
  #set -e
  sudo flatpak install -y flathub "$1"
  # install .desktop file, if it exists
  if [ -f /var/lib/flatpak/exports/share/applications/$1.desktop ]; then
    sudo cp /var/lib/flatpak/exports/share/applications/$1.desktop /usr/share/applications
  fi
}

# Authenticator
installflatpak com.github.bilelmoussaoui.Authenticator

sudo flatpak update -y
