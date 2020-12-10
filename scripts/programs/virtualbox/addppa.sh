#!/bin/bash

addvirtualboxkey () {
  log "Add virtualbox keys..."
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
}

addrepo "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" addvirtualboxkey
