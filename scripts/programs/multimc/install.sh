#!/bin/bash

if [ $(needpkg multimc) ]; then
  log "Installing multimc..."
  instdeb multimc https://files.multimc.org/downloads/multimc_1.4-1.deb
fi
