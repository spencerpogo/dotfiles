#!/bin/bash

debstr="deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(codename) \
stable"

adddockerkey() {
  log "Adding docker key..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
}

addrepo docker "$debstr" adddockerkey
