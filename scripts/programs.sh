#!/bin/bash

set -e

# Update Ubuntu and get standard repository programs
echo "Updating ubuntu..."
sudo apt update && sudo apt full-upgrade -y

# Add PPAs
echo "Adding PPAs..."
for i in programs/*/addppa.sh; do bash $i; done

echo "Updating from APT repos..."
sudo apt update

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

# Esstenials
install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev
install libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev
install libffi-dev liblzma-dev openssl python-openssl git curl gnupg

# Only for really old apt
# install apt-transport-https

# Various programs (wrapping to obey max line length of 88)
install zsh gdb chrome-gnome-shell chromium-browser dialog exfat-utils file htop nmap
install openvpn tree vim wget git-lfs ncdu wine wine-tricks go libimage-exiftool-perl
install gimp jpegoptim optipng xxd bat openjdk-11-jre openjdk-11-jdk flatpak obs-studio

# Fun stuff
install figlet lolcat cowsay

# Actually do the install
echo "Installing packages (this will take a while)..."
# Not double-quoting so it will expand as multiple arguments
sudo apt install $pkgs

# Run all scripts in programs/
echo "Installing programs..."
for f in programs/*.sh; do bash "$f" -H; done

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y

brave-browser 'https://extensions.gnome.org/extension/1160/dash-to-panel/'

# Fun hello
figlet "Hello!" | lolcat

# https://github.com/victoriadrake/dotfiles/blob/ubuntu-19.10/scripts/desktop.sh
# gnome-extensions enable dash-to-panel
# killall -SIGQUIT gnome-shell
# Refactor into separate files

# https://zoom.us/client/latest/zoom_amd64.deb
