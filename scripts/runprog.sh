#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

if [ $# -le 1 ]; then
  echo "Usage: $0 <programs/xxx/addppa.sh>" 1>2
fi
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

# Usage: addrepo <full deb string> [key function]
addrepo () {
  set +e
  grep -F "$1" /etc/apt/sources.list >/dev/null
  r=$?
  set -e

  if [ $r -ne 0 ]; then
    echo "Adding repository:" "$1"
    if [ $# -ge 2 ]; then
      eval "$2"
    fi

    sudo apt-add-repository -yn "$1"
  else
    echo "Skipping repository:" "$1"
  fi
}

source "$1"
