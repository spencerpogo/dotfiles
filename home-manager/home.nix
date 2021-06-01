{ lib, pkgs, ... }:

{
  imports = [
    # CLI
    ./modules/bash.nix
    ./modules/zsh.nix
    ./modules/clitools.nix
    # GUI
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/miscgui.nix
  ];

  programs.home-manager.enable = true;

  # FIXME non-nixos only
  targets.genericLinux.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg)
    [ "vscode-extension-MS-python-vscode-pylance" ];
}
