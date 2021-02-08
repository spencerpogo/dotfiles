#!/bin/bash

orig_dir=$(pwd)

if [ ! -d ~/.oh-my-zsh ]; then
  log "Installing oh-my-zsh..."
  CHSH=yes RUNZSH=no KEEP_ZSHRC=yes ZSH=$HOME/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

cd ~/.oh-my-zsh
git pull

# Powerlevel10k
log "Installing/Updating powerlevel10k..."
p10k_dir=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

if [ ! -d "$p10k_dir" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
fi

cd "$p10k_dir"
git pull

# Autosuggestions
log "Installing/Updating zsh-autosuggestions..."
autos_dir=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

if [ ! -d "$autos_dir" ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$autos_dir"
fi

cd "$autos_dir"
git pull

# zsh-syntax-highlighting
# technically this can be installed through apt. But I think putting it with the other
#  plugins keeps things more organized
log "Installing/Updating fast-syntax-highlighting..."

zsh_synhi_dir=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
  
if [ ! -d "$zsh_synhi_dir" ]; then
  git clone https://github.com/zdharma/fast-syntax-highlighting.git "$zsh_synhi_dir"
fi

cd "$zsh_synhi_dir"
git pull

if [[ "$(command -v gh)" ]]; then
  log "Exporting gh completions..."
  mkdir -p ~/.oh-my-zsh/custom/plugins/gh/
  gh completion --shell zsh > ~/.oh-my-zsh/custom/plugins/gh/gh.plugin.zsh
fi

# Finally...
cd "$orig_dir"
