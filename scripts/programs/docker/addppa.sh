#!/bin/bash

# Always do this, its doesn't take that long
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

set +e
grep '^deb \[arch=amd64\] https://download.docker.com/linux/ubuntu focal stablez$' /etc/apt/sources.list >/dev/null
r=$?
set -e

if [ $r -ne 0 ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  # -n = don't run apt update (aptinstall will later)
  sudo add-apt-repository -yn\
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
fi
