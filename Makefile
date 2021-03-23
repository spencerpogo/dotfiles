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

INITIALPKGS = apt-transport-https ca-certificates curl gnupg gnupg-agent\
software-properties-common

install-initial-apt: ## Installs the APT packages necessary for adding PPAs
	sudo apt update && sudo apt install -y $(INITIALPKGS)

install-apt-repos: ## Adds the APT repos for all the tools. Depends on the install-initial-apt target
	# Generate with for i in ./scripts/programs/*/addppa.sh; do echo "bash ./scripts/runprog.sh $i"; done
	bash ./scripts/runprog.sh ./scripts/programs/brave/addppa.sh
	bash ./scripts/runprog.sh ./scripts/programs/docker/addppa.sh
	bash ./scripts/runprog.sh ./scripts/programs/githubcli/addppa.sh
	bash ./scripts/runprog.sh ./scripts/programs/gitlfs/addppa.sh
	bash ./scripts/runprog.sh ./scripts/programs/obs/addppa.sh
	bash ./scripts/runprog.sh ./scripts/programs/virtualbox/addppa.sh
	bash ./scripts/runprog.sh ./scripts/programs/vsc/addppa.sh
	sudo apt update

install-apt: ## Installs all APT packages. Depends on the install-apt-repos target
	bash ./scripts/runprog.sh ./scripts/apt.sh

install-programs: ## Installs all programs. Some programs depend on the install-apt target
	# Generate with for i in ./scripts/programs/*/install.sh; do echo "bash ./scripts/runprog.sh $i"; done
	bash ./scripts/runprog.sh ./scripts/programs/discord/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/flatpaks/install.sh
	# GNOME extensions installer is not enabled by default. Edit Makefile to enable.
	#bash ./scripts/runprog.sh ./scripts/programs/gnome/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/insomnia/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/multimc/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/node/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/python/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/rust/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/slack/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/stderred/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/steam/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/vsc/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/zoom/install.sh
	bash ./scripts/runprog.sh ./scripts/programs/zsh/install.sh

install-repos: ## Clones github repos
	./scripts/repos.sh

install-all: install-initial-apt install-apt-repos install-apt install-programs
install-all: install-symlinks install-dotconfig install-fonts install-repos ## Install everything	

update: ## Do apt upgrade and autoremove
	sudo apt update && sudo apt upgrade -y --fix-missing
	sudo apt autoremove -y
