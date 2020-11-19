#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

# Shorthand
alias aptinst="sudo apt install -y"

# Usage: if [ $(needpkg <package>) ]; then <install it>; fi
needpkg () {
  set +e
  dpkg -s "$1" 2>1 >/dev/null
  r=$?
  set -e
  if [ $r -ne 0 ]; then
    echo "Missing"
  fi
}

# Add essential packages before getting ppas
sudo apt update && aptinst curl gnupg

# Add PPAs
echo "Adding PPAs..."
for i in ./scripts/programs/*/addppa.sh; do
  source $i
done

# Update Ubuntu and get standard repository programs
echo "Updating ubuntu..."
sudo apt update && sudo apt full-upgrade -y

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
install libffi-dev liblzma-dev openssl python-openssl gnupg gettext

# Only for really old apt
# install apt-transport-https

# Various programs (wrapping to obey max line length of 88)
install zsh gdb chrome-gnome-shell chromium-browser dialog exfat-utils file htop nmap
install openvpn tree vim wget git-lfs ncdu wine winetricks golang xxd bat gimp flatpak
install jpegoptim optipng openjdk-11-jre openjdk-11-jdk obs-studio gnome-tweaks
install brave-browser libimage-exiftool-perl docker-ce docker-ce-cli containerd.io

# Fun stuff
install figlet lolcat cowsay

# Actually do the install
echo "Installing packages (this will take a while)..."
# Not double-quoting so it will expand as multiple arguments
sudo apt install -y $pkgs

# Run all scripts in programs/
echo "Installing programs..."
for f in ./scripts/programs/*/install.sh; do
  # Run scripts in same process so they can access utility functions and have fail-fast
  source "$f"
done

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y

brave-browser 'https://extensions.gnome.org/extension/1160/dash-to-panel/'

# Fun hello
figlet "Hello!" | lolcat
