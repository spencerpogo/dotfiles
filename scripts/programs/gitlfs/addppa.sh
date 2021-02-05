#!/bin/bash

addpkgcloudkey () {
  log "Adding git LFS packagecloud key..."
  curl -L https://packagecloud.io/github/git-lfs/gpgkey | sudo apt-key add -
}

addrepo gitlfs "deb https://packagecloud.io/github/git-lfs/ubuntu/ $(codename) main" addpkgcloudkey
