#!/bin/bash

if [ ! $(command -v rustup) ]; then
  # Install rustup unattended
  log "Installing rustup..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y
  export PATH="$HOME/.cargo/bin:$PATH"
fi

log "Updating rust toolchain..."
rustup update stable
log "Installing rust crates..."
cargo install cargo-tarpaulin bottom
