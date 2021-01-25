#!/bin/bash

export NVM_DIR="$HOME/.nvm"

if [ ! -d ~/.nvm ]; then
  log "📦 Installing nvm"
  (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  )
fi

set +u
. "$NVM_DIR/nvm.sh"

# Always run this to stay fresh
log "Installing latest node..."
nvm install node
log "Installing latest npm..."
nvm install-latest-npm
set -u

log "📦 Installing NPM packages..."
npm i -g replit eslint gitmoji-cli tcp-over-websockets nodemon instant-markdown-d yarn
npm update -g
