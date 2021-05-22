{ pkgs, ... }:

{
  imports = [
    # CLI
    ./modules/bash.nix
    ./modules/zsh.nix
    ./modules/clitools.nix
    # GUI
    ./modules/vscode.nix
  ];

  programs.home-manager.enable = true;
}
