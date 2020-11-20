#!/bin/bash

installvscext () {
  echo "Finding version for $1..."
  version=$(curl -s "https://marketplace.visualstudio.com/items?itemName=$1" | sed -ne 's/^.*"version":[ ]*"\([^"]*\)".*$/\1/p')
  echo "Got version: $version"
  # This is just terrible
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
