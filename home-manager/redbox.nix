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
    ./modules/i3.nix
    ./modules/guiutils.nix
    # TODO: test this and add to cli.nix or parrot.nix
    ./modules/tmux.nix
    # GNOME specific packages and settings
    ./modules/gnome.nix
    ./modules/pentesting.nix
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
