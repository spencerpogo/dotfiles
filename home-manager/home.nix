{ lib, pkgs, ... }:

{
  imports = [ ./cli.nix ./gui.nix ./langs.nix ];

  programs.home-manager.enable = true;

  # FIXME non-nixos only
  targets.genericLinux.enable = true;
}
