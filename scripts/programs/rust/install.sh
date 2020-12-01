#!/bin/bash

if [ ! $(command -v rustup) ]; then
  # Install rustup unattended
  log "Installing rustup..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi
