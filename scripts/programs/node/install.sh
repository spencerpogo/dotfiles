#!/bin/bash

if [ ! -d ~/.nvm ]; then
  echo "📦 Installing nvm"
  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  ) && \. "$NVM_DIR/nvm.sh"
fi

# Always run this to stay fresh
nvm install node
nvm install-latest-npm

# 
echo "📦 Installing NPM packages..."
npm i -g replit eslint gitmoji-cli tcp-over-websockets nodemon instant-markdown-d 
npm update -g
