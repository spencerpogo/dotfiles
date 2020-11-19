#!/bin/bash

# Is it already installed?
dpkg -s "codium" &> /dev/null
if [ codium -ne 1 ]; then
  echo "⌨️  Installing VSCode"
  sudo apt install codium
fi

echo "Installing extensions..."
<../.config/VSCodium/User/extensions.txt xargs -d '\n' -I {} codium --install-extension {} --force
