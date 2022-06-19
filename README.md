# Scoder12 NixOS Dotfiles

## My setup

- Usecase: Full-stack development, browsing, light gaming
- OS: NixOS Unstable
- Install everything using `home-manager`, never `nix-env`.
  - Ensures that everything I install is saved in my dotfiles
  - Don't use two tools for the same purpose
- Try to keep tools in home-manager to essentials and use `nix-shell -p` for everything
  else
  - can try out new software instantly with no need to remember to remove
  - saves disk space
  - avoids bloating base dotfiles install
- Use `home-manager` standalone rather than as a module
  - can update system and user independently
- Shell: zsh
  - no framework, plugins are managed by nix
  - nerdfont complete powerlevel10k theme
  - lots of custom aliases and functions
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
nixos-rebuild switch --use-remote-sudo
```

The NixOS config sets up `NIX_PATH` to use the nixpkgs version pinned in this flake, so
you should `sudo nix-channel --remove` all your system channels now (list them with
`sudo nix-channel --list`)

### Other linux

[Install](https://nixos.org/guides/install-nix.html) the nix package manager.

### home-manager (flake)

1. Choose or add a `homeConfiguration` flake output with the correct username
2. Refer to [the home-manager manual](https://nix-community.github.io/home-manager/index.html#sec-flakes-standalone).
   The flake URI is simply the path to this git repo.

### home-manager (non-flakes)

Note: I use flakes rather than this method on all my systems now.

1. Install [home-manager](https://github.com/nix-community/home-manager) using the
   **standalone installation**: [instructions in the home-manager manual](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).
2. At the top of `~/.config/nixpkgs/home.nix`, import your desired machine config from
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

Note: On non-NixOS, nix's libGL doesn't play nicely with system graphics drivers, so
[install alacritty's dependencies](https://github.com/alacritty/alacritty/blob/master/INSTALL.md#dependencies)
using the system package manager then `cargo install alacritty`, rather than installing
it with nix.

### Important tips

- Don't forget to `sudo nix-collect-garbage -d` often.
- Keep your system up to date: `nix flake update --commit-lock-file`
- Make sure to set `max-jobs` and `cores` when building
  ([manual](https://nixos.org/manual/nix/stable/advanced-topics/cores-vs-jobs.html)).
  I use `--max-jobs 1 --cores 2` with `home-manager switch` and `nixos-rebuild switch`
  to avoid overselling my 6-core 12-thread machine
- The Firefox User-Agent in `home-manager/modules/firefox.nix` is spoofed to look like
  Win10. Be sure to check the [list](https://techblog.willshouse.com/2012/01/03/most-common-user-agents)
  from time to time to makek sure it isn't being generated incorrectly and standing out
