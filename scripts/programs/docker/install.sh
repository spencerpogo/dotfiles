#!/bin/bash

if [ ! $(command -v docker) ]; then
  echo "🐋 Installing Docker"
  sudo apt install -y docker-ce docker-ce-cli containerd.io
  sudo docker run hello-world
fi
