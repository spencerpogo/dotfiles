{ lib, pkgs, ... }:

{
  imports = [
    ./modules/cli.nix
    ./modules/gui.nix
    ./modules/rust.nix
    ./modules/python.nix
  ];

  programs.home-manager.enable = true;

  # enable non-nixos
  targets.genericLinux.enable = true;
}
