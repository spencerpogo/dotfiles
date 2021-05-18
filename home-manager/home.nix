{ pkgs, ... }:

{
  imports = [
    ./modules/bash.nix
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ bash ];

}
