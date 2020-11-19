#!/bin/bash

if [ ! -f /etc/apt/sources.list.d/gitlfs.list ]; then
  curl -L https://packagecloud.io/github/git-lfs/gpgkey | sudo apt-key add -
  echo "deb https://packagecloud.io/github/git-lfs/ubuntu/ focal main" | sudo tee /etc/apt/sources.list.d/gitlfs.list
fi
