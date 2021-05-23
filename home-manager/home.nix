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
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg)
    [ "vscode-extension-MS-python-vscode-pylance" ];
}
