#!/bin/bash

addgithubclikey() {
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
  sudo apt-add-repository https://cli.github.com/packages
}

addrepo "deb https://cli.github.com/packages $(lsb_release -cs) main" addgithubclikey
