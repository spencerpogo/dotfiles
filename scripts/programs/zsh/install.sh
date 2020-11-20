#!/bin/bash

orig_dir=$(pwd)

if [ ! -d ~/.oh-my-zsh ]; then
  echo "Installing oh-my-zsh..."
  if [ ! "$(basename -- "$SHELL")" = "zsh" ]; then
    sudo chsh -s "zsh"
  fi
  sudo RUNZSH=no KEEP_ZSHRC=yes ZSH=$HOME/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

cd ~/.oh-my-zsh
git pull

# Powerlevel10k
echo "Installing/Updating powerlevel10k..."
p10k_dir=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

if [ ! -d "$p10k_dir" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
fi

cd "$p10k_dir"
git pull

# Autosuggestions
echo "Installing/Updating zsh-autosuggestions..."
autos_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if [ ~d "$autos_dir" ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$autos_dir"
fi

cd "$autos_dir"
git pull

# zsh-syntax-highlighting
# technically this can be installed through apt. But I think putting it with the other
#  plugins keeps things more organized
echo "Installing/Updating powerlevel10k..."

zsh_synhi_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

if [ ! -d "$zsh_synhi_dir" ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_synhi_dir"
fi

cd "$zsh_synhi_dir"
git pull

# Finally...
cd "$orig_dir"
