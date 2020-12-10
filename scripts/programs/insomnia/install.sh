

if [ $(needpkg insomnia) ]; then
  log "Installing insomnia..."
  instdeb insomnia https://updates.insomnia.rest/downloads/ubuntu/latest
fi
