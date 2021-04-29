#!/bin/bash

# Add flathub repo
log "Adding flathub repo..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

installflatpak () {
  log "Installing flatpak:" "$1"
  #set -e
  sudo flatpak install -y flathub "$1"
  # install .desktop file, if it exists.
  # (just in case flatpak isn't in XDG_DATA_DIRS). 
  # On my system, I have /etc/profile.d/flatpak.sh
  # which sets it for me, but not sure how it got there.
  if [ -f /var/lib/flatpak/exports/share/applications/$1.desktop ]; then
    sudo cp /var/lib/flatpak/exports/share/applications/$1.desktop /usr/share/applications
  fi
}

# Authenticator
installflatpak com.belmoussaoui.Authenticator
# Peek
installflatpak com.uploadedlobster.peek
# Inkscape
installflatpak org.inkscape.Inkscape
# Obsidian
installflatpak md.obsidian.Obsidian

log "Updating flatpaks..."
sudo flatpak update -y
