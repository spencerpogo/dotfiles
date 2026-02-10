{
  lib,
  pkgs,
  ...
}:
# Shared configuration for all profiles.
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vscode-extension-MS-python-vscode-pylance"
      "vscode-extension-ms-vscode-cpptools"
      "vscode-extension-ms-toolsai-jupyter"
      "vscode-extension-ms-vsliveshare-vsliveshare"
      "vscode-extension-ms-vscode-remote-remote-containers"
      "steam"
      "steam-original"
      "steam-runtime"
      "obsidian"
      "discord"
      "zoom"
      "spotify"
      "spotify-unwrapped"
      "slack"
    ];

  programs.home-manager.enable = true;
}
