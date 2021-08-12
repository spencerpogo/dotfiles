{ lib, pkgs, ... }:

{
  imports = [
    ./modules/cli.nix
    ./modules/rust.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/guiutils.nix
    # GNOME specific packages and settings
    ./modules/gnome.nix
  ];

  programs.home-manager.enable = true;

  # enable non-nixos
  targets.genericLinux.enable = true;
}
