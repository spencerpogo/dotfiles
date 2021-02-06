SHELL := /bin/bash

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Saving section

save-dconf: ## Save dconf settings into the repo
	dconf dump /org/gnome/ > ./.config/dconf/settings.dconf
	cp ~/.config/pulse/daemon.conf ./.config/pulse/daemon.conf

save-vsc-settings: ## Save VS Code configuration files into the repo
	cp -r ~/.config/VSCodium/User/{settings.json,keybindings.json,snippets} ./.config/VSCodium/User

save-vsce: ## Save a list of VSC extensions into the repo
	codium --list-extensions > ./.config/VSCodium/User/extensions.txt

save-fonts:
	rm -rf ./.fonts
	cp -r ~/.fonts .

save-all: save-dconf save-vsc-settings save-vsce save-fonts
save-all: ## Run all save-* actions

# Installation section

install-symlinks: ## Symlinks dotfiles
	./scripts/symlink.sh

install-dotconfig: ## Copy .config files
	cp -r .config ~

install-fonts: ## Copy fonts and refresh font cache
	cp -r .fonts ~
	fc-cache -f -v

install-programs: ## Installs all APT packages and programs under ./scripts/programs
	./scripts/programs.sh

install-repos: ## Clones github repos
	./scripts/repos.sh

install-all: install-programs install-symlinks install-dotconfig install-fonts
install-all: install-repos ## Install everything	

update: ## Do apt upgrade and autoremove
	sudo apt update && sudo apt upgrade -y --fix-missing
	sudo apt autoremove -y
