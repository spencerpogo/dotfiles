#!/bin/bash

if [ ! $(command -v slack) ]; then
  log "Installing slack..."
  # Sadly, slack does not have a "latest" endpoint
  instdeb slack https://downloads.slack-edge.com/linux_releases/slack-desktop-4.11.1-amd64.deb
fi
