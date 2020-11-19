#!/bin/bash

dpkg -s "brave-browser" >/dev/null
if [ $? -ne 0 ]; then
  echo "Installing brave..."
  sudo apt install brave-browser
fi

# TODO: Unzip encrypted backup
