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
      "antigravity-cli"
      "claude-code"
      "codex"
      "discord"
      "discord-unwrapped"
      "obsidian"
      "slack"
      "spotify"
      "spotify-unwrapped"
      "steam"
      "steam-original"
      "steam-runtime"
      "vscode-extension-MS-python-vscode-pylance"
      "vscode-extension-ms-toolsai-jupyter"
      "vscode-extension-ms-vscode-cpptools"
      "vscode-extension-ms-vscode-remote-remote-containers"
      "vscode-extension-ms-vsliveshare-vsliveshare"
      "zoom"
    ];

  programs.home-manager.enable = true;
}
