{ pkgs, ... }:
{
  imports = [
    ./cli.nix

    ../modules/python.nix
    ../modules/vscode/vscode.nix
    ../modules/firefox.nix
    ../modules/tmux.nix
    ../modules/flameshot.nix
    ../modules/fonts.nix
    ../modules/alacritty.nix
    ../modules/ssh.nix
    ../modules/vim.nix
    ../modules/neovim/neovim.nix
  ];

  home.sessionVariables.BROWSER = "${pkgs.firefox}/bin/firefox";

  home.packages = with pkgs; [
    ungoogled-chromium
    discord
    signal-desktop
    zoom-us
    obs-studio
    pavucontrol
    gcc
    unzip
    mpv
    spotify
    fastfetch
    ripgrep
    jq
    htop
  ];
}
