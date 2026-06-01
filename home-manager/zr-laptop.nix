{
  config,
  lib,
  pkgs,
  system-nixos-config,
  ...
}:
{
  # work laptop nix-darwin

  imports = [
    ./configs/base.nix
    ./configs/cli.nix

    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/tmux.nix
    # ./modules/gtk.nix
    ./modules/kitty.nix
    ./modules/ssh.nix
    ./modules/vim.nix
    ./modules/neovim/neovim.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  home.packages = with pkgs; [
    # compile
    gcc
    # flex
    fastfetch
    # search
    ripgrep
    # json tool
    jq
    # nix code formatting
    nixfmt
    # notes
    obsidian
    # process management
    htop
    # media processing
    ffmpeg
  ];
}
