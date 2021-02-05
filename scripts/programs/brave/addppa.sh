#!/bin/bash

addbravekey () {
  log "Adding brave key..."
  curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
}

addrepo brave "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" addbravekey
