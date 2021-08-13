{ lib, pkgs, ... }:

{
  # My desktop PC

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

  home.packages = [
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
