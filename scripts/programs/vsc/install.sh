#!/bin/bash

echo "Installing extensions..."
set +e
<~/.config/VSCodium/User/extensions.txt xargs -d '\n' -I {} codium --install-extension {} --force
set -e
