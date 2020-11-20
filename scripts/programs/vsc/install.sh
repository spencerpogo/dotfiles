#!/bin/bash

installvscext () {
  echo "Finding version for $1..."
  version=$(curl -s https://marketplace.visualstudio.com/items\?itemName\=EliverLara.andromeda | sed -ne 's/^.*"version":[ ]*"\([^"]*\)".*$/\1/p')
  echo "Got version: $version"
  # This is just terrible
  path=$(echo "$1./vsextensions/" | awk -F '.' '{ print $1 $3 $2 }')
  url="https://marketplace.visualstudio.com/_apis/public/gallery/publishers/$path/$version/vspackage"
  vsix="~/Downloads/$1.vsix"

  echo "Downloading $url..."
  wget -O "$vsix" "$url"
  echo "Installing..."
  codium --install-extension "$vsix" --force
}

echo "Installing extensions..."
set +e
<~/.config/VSCodium/User/extensions.txt xargs -n1 installvscext
set -e
