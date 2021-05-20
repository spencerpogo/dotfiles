# Scoder12 NixOS Dotfiles

### home-manager setup

1. Install [home-manager](https://github.com/nix-community/home-manager).
2. Edit `home-manager/home.nix` if neccessary
3. At the top of `~/.config/nixpkgs/home.nix`, import the `home-manager/home.nix` file
   from this repository:

```nix
{ config, pkgs, ... }:

{
  imports = [
    ../../code/dotfiles/home-manager/home.nix
  ];

  # --snip--
```

3. Rebuild home-manager config
