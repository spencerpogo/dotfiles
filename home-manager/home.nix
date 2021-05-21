{ pkgs, ... }:

{
  imports = [
    # CLI
    ./modules/bash.nix
    ./modules/zsh.nix
    ./modules/clitools.nix
  ];

  programs.home-manager.enable = true;  
}
