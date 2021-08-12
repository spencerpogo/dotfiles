{ lib, pkgs, ... }:

{
  imports = [ ./cli.nix ./gui.nix ./langs.nix ];

  programs.home-manager.enable = true;

  # enable non-nixos
  targets.genericLinux.enable = true;
}
