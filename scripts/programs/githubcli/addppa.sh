#!/bin/bash

addgithubclikey() {
  log "Adding Github CLI key..."
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
}

addrepo "deb https://cli.github.com/packages $(lsb_release -cs) main" addgithubclikey
