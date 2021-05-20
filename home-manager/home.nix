{ pkgs, ... }:

{
  imports = [
    # CLI
    ./modules/bash.nix
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;  
}
