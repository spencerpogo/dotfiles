SHELL := /bin/bash

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Saving section

save-dconf: ## Save dconf settings into the repo
	dconf dump /org/gnome/ > ./.config/dconf/settings.dconf

save-vsc-settings: ## Save VS Code configuration files into the repo
	cp ~/.config/VSCodium/User/{settings.json,extensions.txt,keybindings.json} ./.config/VSCodium/User

save-vsce: ## Save a list of VSC extensions into the repo
	codium --list-extensions > ./.config/VSCodium/User/extensions.txt

save-fonts:
	rm -rf ./.fonts
	cp -r ~/.fonts .

save-zshrc: ## Saves .zshrc into the repo
	cp ~/.zshrc ./.zshrc

save-vimrc: ## Saves .vimrc into the repo
	cp ~/.vimrc ./.vimrc

save-dotfiles: save-zshrc save-vimrc ## Saves all dotfiles into the repo

save-all: save-dconf save-vsc-settings save-vsce save-dotfiles save-fonts
save-all: ## Run all save-* actions

# Installation section

install-programs: ## Installs all APT packages and programs under ./scripts/programs
	./scripts/programs.sh

install-dconf: ## Loads dconf settings
	dconf load /org/gnome < ./config/dconf/settings.dconf

install-symlinks: ## Symlinks dotfiles
	./scripts/symlink.sh

install-fonts: ## Copy fonts and refresh font cache
	cp -r .fonts ~
	fc-cache -f -v

install-dotconfig: ## Copy .config files
	cp -r .config ~

install-backup: ## Decrypts and extracts the backup
	openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in "./files/backup.tar.gz.enc" -out "./files/backup.tar.gz"
	tar -C ~ -xzf "./files/backup.tar.gz"
	rm -rf "./files/backup.tar.gz"

update: ## Do apt upgrade and autoremove
	sudo apt update && sudo apt upgrade -y --fix-missing
	sudo apt autoremove -y

install-all: install-programs install-dconf install-symlinks install-fonts
install-all: install-dotconfig install-backup ## Install everything	
