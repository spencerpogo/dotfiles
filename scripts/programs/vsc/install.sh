#!/bin/bash

verlte() {
  if [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]; then
    echo yes
  fi
}
export -f verlte

getextversion () {
  set +e
  ext=$(codium --list-extensions --show-versions | grep -F "$1" 2>/dev/null)
  set -e
  if [ "$ext" ]; then
    echo "$ext" | awk -F@ '{ print $2 }'
  fi
}
export -f getextversion

installvscext () {
  #set -euo pipefail
  #shopt -s inherit_errexit

  log "Installing VSCodium extension:" "$1"
  echo "Finding version for $1..."
  # Regex go brrrr
  version=$(curl -s "https://marketplace.visualstudio.com/items?itemName=$1" |
    sed -ne 's/<script class="jiContent" defer="defer" type="application\/json">\(.*\)<\/script>/\1/p' |
    jq -r '.Versions[0]["version"]')
  echo "Got online version: $version"

  installed=$(getextversion "$1")
  echo "Installed version: $installed"
  if [ $(verlte "$version" "$installed") ]; then
    echo "Installed is newer, skipping."
    exit 0
  fi

  # This is a pretty bad way of doing this. Need to split $1 into two parts by . and
  #  put /vsextensions/ in the middle. This is an awk hack for that:
  exturlpart=$(echo "$1./vsextensions/" | awk -F '.' '{ print $1 $3 $2 }')
  url="https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$exturlpart/$version/vspackage"
  vsix="$HOME/Downloads/$1.vsix"

  dlfinished=
  while [ ! $dlfinished ]; do
    echo "Downloading $url..."
    curl --compressed --output "$vsix" "$url"
    file "$vsix" | grep 'Zip' >/dev/null
    if [ $? -eq 0 ]; then
      dlfinished=yes
    else
      file "$vsix"
      echo "Bad zip, we are probably ratelimited, will retry in 5s..."
      sleep 5
    fi
  done

  echo "Installing..."
  codium --install-extension "$vsix" --force
}
export -f installvscext

echo "Installing extensions..."
set +e
<~/.config/VSCodium/User/extensions.txt xargs -I {} bash -c 'installvscext "$@"' _ {}
set -e
