#!/bin/bash

echo "Installing extensions..."
<~/.config/VSCodium/User/extensions.txt xargs -d '\n' -I {} codium --install-extension {} --force
