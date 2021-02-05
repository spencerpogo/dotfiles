#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

if [ $# -lt 1 ]; then
  echo "Usage: $0 <programs/xxx/addppa.sh>" >&2
  exit 1
fi

# Shorthand
aptinst () {
  sudo apt install -y $@
}
export -f aptinst

# Usage: if [ $(needpkg <package>) ]; then <install it>; fi
needpkg () {
  set +e
  dpkg -s "$1" >/dev/null 2>&1
  r=$?
  set -e
  if [ $r -ne 0 ]; then
    echo "Missing"
  fi
}

codename () {
  echo ${CODENAME:-$(lsb_release -cs)}
}

# Usage: addrepo <full deb string> <name> [key function]
addrepo () {
  set +e
  grep -F "$1" /etc/apt/sources.list $(find /etc/apt/sources.list.d -type f -name "*.list" 2>/dev/null) >/dev/null
  r=$?
  set -e

  if [ $r -ne 0 ]; then
    echo "Adding repository:" "$1"
    if [ $# -ge 3 ]; then
      eval "$2"
    fi

    echo "$2" | sudo tee /etc/apt/sources.list.d/$1.list
  else
    echo "Skipping repository:" "$1"
  fi
}

# Usage: instdeb <filenamename> <url>
instdeb () {
  fname=$HOME/Downloads/$1.deb
  wget -O "$fname" "$2"
  aptinst "$fname"
  rm "$fname"
}

log () {
  echo ${LOG_PREFIX:-"=======>"} $@
}
export -f log

source "$1"
