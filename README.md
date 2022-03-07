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
- Use `home-manager` standalone rather than as a module
  - can update system and user independently
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

### NixOS (flake)

```sh
sudo ln -s /path/to/dotfiles/flake.nix /etc/nixos/flake.nix
sudo nixos-rebuild switch
```

You should be able to `sudo nix-channel --remove` all your channels now (list them with
`sudo nix-channel --list`)

### Other linux

[Install](https://nixos.org/guides/install-nix.html) the nix package manager.

### home-manager (flake)

Refer to [the home-manager manual](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone).
The flake URI is simply the path to this git repo.

**Updating:** You can use the `nix flake update` (or `nix flake lock --update-input <input>`).
Adding `--commit-lock-file` can be helpful.

### home-manager (non-flakes)

1. Install [home-manager](https://github.com/nix-community/home-manager) using the
   **standalone installation**: [instructions in the home-manager manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).
1. Pick an existing profile from `home-manager/*.nix`, or create a new one to customize
   the installed programs.
1. At the top of `~/.config/nixpkgs/home.nix`, import your desired machine config from
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

**Updating:** Make sure to update your system `nixpkgs` channel (may have to use `sudo` depending on
installation method) and the `home-manager` channel. Update `stateVersion` in
`~/.config/nixpkgs/home.nix` when necessary to stay up-to-date with breaking changes.

Note: Nix's libGL doesn't work very well, so on non-nixos
[install alacritty's dependencies](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#dependencies)
using the system package manager them `cargo install alacritty`

### Misc tips

- Don't forget to `sudo nix-collect-garbage -d` often.
- Keep your system up to date.
