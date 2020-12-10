
INSOMNIA_DEB=$HOME/Downloads/insomnia.deb

if [ $(needpkg insomnia) ]; then
  log "Installing insomnia..."
  wget -O $INSOMNIA_DEB https://updates.insomnia.rest/downloads/ubuntu/latest
  aptinst $INSOMNIA_DEB
  rm $INSOMNIA_DEB
fi
