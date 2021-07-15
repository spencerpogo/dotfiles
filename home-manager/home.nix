{ lib, pkgs, ... }:

{
  imports = [ ./cli.nix ./gui.nix ./langs.nix ];

  programs.home-manager.enable = true;

  # FIXME non-nixos only
  targets.genericLinux.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode-extension-MS-python-vscode-pylance"
      "vscode-extension-ms-vscode-cpptools"
      "vscode-extension-ms-toolsai-jupyter"
      "vscode-extension-ms-vsliveshare-vsliveshare"
      "steam"
      "steam-original"
      "steam-runtime"
      "obsidian"
    ];
}
