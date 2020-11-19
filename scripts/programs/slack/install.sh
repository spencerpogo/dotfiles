#!/bin/bash

if [ ! $(command -v slack) ]; then
  echo "Installing slack..."
  # Sadly, slack does not have a "latest" endpoint
  wget -O ~/Downloads/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-4.11.1-amd64.deb
  # Install it
  aptinst ~/Downloads/slack.deb
  # Clean up
  rm -f ~/Downloads/slack.deb
fi
