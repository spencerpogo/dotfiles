{ lib, pkgs, ... }:

{
  imports = [ ./cli.nix ./gui.nix ./modules/rust.nix ./modules/python.nix ];

  programs.home-manager.enable = true;

  # enable non-nixos
  targets.genericLinux.enable = true;
}
