{ lib, pkgs, ... }:

{
  # My desktop PC, running Pop! OS
  # Rationale: it is nice to have apt in a pinch or in a time-sensitive situation where
  #  I can't afford to waste time fighting with nix

  imports = [
    ./modules/base.nix
    ./modules/cli.nix
    ./modules/rust.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/guiutils.nix
    # GNOME specific packages and settings
    ./modules/gnome.nix
  ];

  home.packages = with pkgs; [
    # command-line color picker
    xcolor
    # note-taking
    obsidian
    # secondary browser, for school and WebGL stuff
    ungoogled-chromium
    # chat
    discord
  ];
}
