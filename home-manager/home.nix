{ pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ bash ];

}
