# Scoder12 NixOS Dotfiles

## My setup

- Usecase: Full-stack development, browsing, light gaming
- OS: Pop! OS 20.10
  - Tried to use NixOS, installation was painful and never ended up
    getting it to work how I wanted
  - Pop is ubuntu but with many quality of life fixes and better theming.
  - Ubuntu/debian has great community, documentation, and support, plus I have a lot of
    experience with it
  - it is nice to have apt in a pinch
- Use nix package manager for everything, keep apt use to the bare minimum utilities
- Install everything using `home-manager`, never `nix-env`.
  - Ensures that everything I install is saved in my dotfiles
  - Don't use two tools for the same purpose
- Always use `nix-shell -p` instead of home-manager except for everyday essentials
  - allows faster iteration
  - avoids bloating base dotfiles install
- Shell: zsh
  - oh-my-zsh because it has a lot of quality of life fixes and a great git plugin
  - nerdfont complete powerlevel10k theme
  - use `paste` and `copy` aliases heavily in pipes
  - terminal: gnome-terminal because it is built in, works great, and handles my theme
    better than any other xterm I've tried (others have weird issues with unicode shade
    characters)
- Editor: VS Codium (open source, telemetry free VS Code) with vscode-vim extension
  and sometimes vim with default config
- See comments in `home-manager/modules/*.nix` for more information

## Installation

### home-manager setup (non-nixos)

1. [Install nix package manager](https://nixos.org/guides/install-nix.html) (multi-user setup recommended).
2. Install [home-manager](https://github.com/nix-community/home-manager).
3. Clone this repository and edit `home-manager/home.nix` to enable/disable modules to
   your liking. By default, it will install several GUI programs.
4. Pick an existing profile from `home-manager/*.nix`, or create a new one.
5. At the top of `~/.config/nixpkgs/home.nix`, import your desired profile from this
   repository, editing the path as necessary. For example, to use the `redbox` profile
   after cloning the repository to `/home/scoder12/github/dotfiles`, write:

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
