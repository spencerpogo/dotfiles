#!/bin/bash

debstr="deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

adddockerkey() {
  echo "Adding docker key..."
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
}

addrepo $debstr adddockerkey
