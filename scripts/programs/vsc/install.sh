#!/bin/bash

EXTDIR=$HOME/.vscode-oss/extensions

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

findextwithname () {
  for ext in $(ls -1 ~/.vscode-oss/extensions); do
    manifest=$EXTDIR/$ext/package.json
    name=$(<$manifest jq -r '.displayName')
    if [ "$name" = "$1" ]; then
      # output extension ID
      <$manifest jq -r '.publisher + "." + .name'
      return 0
    fi
  done
}

uninstallext () {
  code=0
  errs=
  while [ "$code" -eq 0 ]; do
    echo "Uninstalling $1"

    set +e
    errs=$(codium --uninstall-extension "$1" 2>&1 1>/dev/null)
    code=$?
    set -e

    echo "errs: $errs"
    if [ "$errs" ]; then
      dep=$(echo "$errs" | tail -n1 | sed -ne "s/Cannot uninstall '\(.*\)' extension. '\(.*\)' extension depends on this./\2/p")
      if [ "$dep" ]; then
        echo "Tried to uninstall $1 but the '$dep' extension depends on it. "
  
        while true; do
          echo "Searching for extension with name $dep"
          depid=$(findextwithname "$dep")
          if [ ! "$depid" ]; then
            echo "No more matches for $dep"
            break
          fi

          echo "Found ID for the '$dep' extension: $depid, will recursively uninstall it..."
          uninstallext "$depid"
        done

        echo "Handled dependent extension $dep"
        # can potentially cause infinite loop but whatever
        code=0
      fi
    fi
  done
}
export -f uninstallext

installvscext () {
  set -euo pipefail
  shopt -s inherit_errexit

  log "Installing VSCodium extension:" "$1"
  if [ "$1" -eq "esbenp.prettier-vscode" ]; then
    version=5.8.0
  else
    echo "Finding version for $1..."
    # Regex go brrrr
    version=$(curl -s "https://marketplace.visualstudio.com/items?itemName=$1" |
      sed -ne 's/<script class="jiContent" defer="defer" type="application\/json">\(.*\)<\/script>/\1/p' |
      jq -r '.Versions[0]["version"]')
    echo "Got online version: $version"

    installed=$(getextversion "$1")
    echo "Installed version: $installed"
    if [ $(verlte "$version" "$installed") ]; then
      echo "Extension is up to date."
      return 0
    fi
  fi
  
  uninstallext "$1"

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
  rm -rf "$vsix"
}
export -f installvscext

echo "Installing extensions..."
while read i; do
 installvscext "$i"
done <~/.config/VSCodium/User/extensions.txt
