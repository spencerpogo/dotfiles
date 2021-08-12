{ pkgs, lib, ... }:

{
  imports = [
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/guiutils.nix
    # GNOME specific packages and settings
    ./modules/gnome.nix
  ];
}
