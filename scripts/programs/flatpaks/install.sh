#!/bin/bash

# Add flathub repo
log "Adding flathub repo..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

installflatpak () {
  log "Installing flatpak:" "$1"
  #set -e
  sudo flatpak install -y flathub "$1"
  # install .desktop file, if it exists
  if [ -f /var/lib/flatpak/exports/share/applications/$1.desktop ]; then
    sudo cp /var/lib/flatpak/exports/share/applications/$1.desktop /usr/share/applications
  fi
}

# Authenticator
installflatpak com.github.bilelmoussaoui.Authenticator

log "Updating flatpaks..."
sudo flatpak update -y
