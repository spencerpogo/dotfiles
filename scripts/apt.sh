#!/bin/bash

pkgs=

#function install {
#  dpkg -s "$1" &> /dev/null
#
#  if [ $? -ne 0 ]; then
#    echo "Will install ${1}..."
#    sudo apt install "${1}"
#  else
#    echo "Already installed: ${1}"
#  fi
#}

function install {
  pkgs="${pkgs} ${@}"
}

# Essentials
install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev git curl
install libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev
install libffi-dev liblzma-dev openssl gnupg gettext cmake

# Only for really old apt
# install apt-transport-https

# Various programs (wrapping to obey max line length of 88)
install zsh gdb chrome-gnome-shell dialog exfat-utils file htop nmap
install openvpn tree vim wget git-lfs ncdu wine winetricks golang xxd bat gimp flatpak
install jpegoptim optipng openjdk-11-jre openjdk-11-jdk obs-studio gnome-tweaks xclip
install brave-browser libimage-exiftool-perl docker-ce docker-ce-cli containerd.io jq
install codium gh clipit haskell-platform pandoc texlive
install inkscape dconf-cli uuid-runtime audacity pstoedit gir1.2-gtksource-3.0
install python3-gi gir1.2-gtk-3.0 flatpak ffmpeg obs-studio virtualbox virtualbox-qt
install virtualbox-dkms ripgrep gnome-shell-pomodoro git-lfs

# Fun stuff
install figlet lolcat cowsay

# Actually do the install
pkgcount=$(echo $pkgs | sed 's/ /\n/g' | sed '/^$/d' | wc -l)
log "Installing $pkgcount packages and their dependencies (this will take a while)..."
# Not double-quoting so it will expand as multiple arguments
sudo apt install -y $pkgs

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y

log "Opening extensions in browser..."
<extensions.txt xargs -n1 -I {} bash -c \
  'brave-browser https://chrome.google.com/webstore/detail/{} >/dev/null 2>&1  &'
# brave-browser 'https://extensions.gnome.org/extension/1160/dash-to-panel/' >/dev/null &

# Fun hello
figlet "All done!" | lolcat
