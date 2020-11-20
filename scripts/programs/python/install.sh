#!/bin/bash


if [ ! -d ~/.pyenv ]; then
  echo "🐍 Installing pyenv..."
  curl https://pyenv.run | bash
fi

# These are in .zshrc but have to run now to get `pyenv` command
export PATH="$HOME/.pyenv/bin:$PATH"
set +u
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo "🐍 Building python versions..."
if [ ! -d ~/.pyenv/versions/3.8.6 ]; then
  pyenv install 3.8.6
fi
if [ ! -d ~/.pyenv/versions/3.7.7 ]; then
  pyenv install 3.7.7
fi

pyenv local 3.8.6 3.7.7

# Global python packages, always run to keep it fresh
echo "Installing python packages..."
pip install --upgrade pip wheel
pip install --upgrade requests flask aiohttp black numpy scipy pandas jupyter pwntools

set -u
