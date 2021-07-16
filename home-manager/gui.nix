{ pkgs, lib, ... }:

{
  imports = [
    ./modules/vscode.nix
    ./modules/firefox.nix
    # GNOME specific packages and settings
    ./modules/gnome.nix
  ];

  home.packages = with pkgs; [ xcolor obsidian ungoogled-chromium discord ];

  fonts.fontconfig.enable = true;

  home.keyboard.options = [ "caps:escape_shifted_capslock" ];

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
      "discord"
    ];
}
