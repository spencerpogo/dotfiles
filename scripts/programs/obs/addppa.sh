#!/bin/bash

addobskey () {
  log "Adding OBS key..."
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key BC7345F522079769F5BBE987EFC71127F425E228
}

addrepo obs "deb http://ppa.launchpad.net/obsproject/obs-studio/ubuntu $(codename) main"
