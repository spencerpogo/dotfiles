# Scoder12 NixOS Dotfiles

## My setup

- Usecase: Full-stack development, browsing, light gaming
- OS: NixOS Unstable
- Install everything using `home-manager`, never `nix-env`.
  - Ensures that everything I install is saved in my dotfiles
  - Don't use two tools for the same purpose
- Try to keep tools in home-manager to essentials and use `nix-shell -p` for everything
  else
  - try out new software instantly with no need to remember to remove
  - save disk space
  - avoids bloating base dotfiles install
- Shell: zsh
  - oh-my-zsh because it has a lot of quality of life fixes and git plugin has good
    aliases
  - nerdfont complete powerlevel10k theme
  - use `p` and `c` (shorthand for `paste` and `copy`) aliases heavily in pipes
- Terminal: alacritty
- Editors:
  - VS Codium (open source, telemetry free VS Code) with vscode-vim extension
  - vanilla vim with no config

## Repo organization

- `home-manager/`
  - Modules in `modules/*.nix` Machines in `*.nix`:
    - Each machine can enable/disable modules based on situation, whether it is GUI,
      etc.
    - Modules are for a specific tool that needs configuring or a set of similar tools
    - if it fits in 1 line or package doesn't need to be configured it doesn't need it's
      own module, it can be put in the machine config
    - Modules are sometimes interdependent, e.g. i3 terminal is set to alacritty if that
      module is enabled

## Installation

### NixOS

Symlink `/etc/nixos/configuration.nix` to `nixos/configuration.nix` in this repo.
Rebuild config with `sudo nixos-rebuild boot` or `sudo nixos-rebuild switch` (see the
manpage for details).

### Other linux

[Install](https://nixos.org/guides/install-nix.html) the nix package manager.

### home-manager setup

1. Install [home-manager](https://github.com/nix-community/home-manager).
2. Clone this repository and edit `home-manager/home.nix` to enable/disable modules to
   your liking. By default, it will install several GUI programs.
3. Pick an existing profile from `home-manager/*.nix`, or create a new one.
4. At the top of `~/.config/nixpkgs/home.nix`, import your desired machine config from
   this repo using an absolute path. For example, to use the `redbox` profile after
   cloning the repository to `/home/scoder12/github/dotfiles`, write:

```nix
{ config, pkgs, ... }:

{
  imports = [
    /home/scoder12/github/dotfiles/home-manager/redbox.nix
  ];

  # --snip--
```

3. Rebuild home-manager config: `home-manager switch`. Repeat this step after any
   change to this repository.
