{ lib, pkgs, ... }:

{
  # My desktop PC, running NixOS

  nixpkgs.overlays = let
    owner = "NixOS";
    branchname = "master";
    pkgsReview = pkgs.fetchzip {
      url = "https://github.com/${owner}/nixpkgs/archive/${branchname}.tar.gz";
      sha256 = "sha256-E1kUarSqi6l8/ycXH4DtYPxk2Bv5SlGFVb2k2WZgbX8=";
    };
  in [
    (self: super: {
      review = import pkgsReview {
        overlays = [ ];
        config = super.config;
      };
      discord = self.review.discord;
    })
  ];

  imports = [
    ./configs/base.nix
    ./configs/cli.nix

    ./modules/rust.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/i3.nix
    ./modules/guiutils.nix
    ./modules/tmux.nix
    ./modules/gtk.nix
    ./modules/flameshot.nix
    ./modules/fonts.nix
    ./modules/alacritty.nix
    ./modules/ssh.nix
    ./modules/vim.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  home.packages = with pkgs; [
    # command-line color picker
    xcolor
    # note-taking
    obsidian
    # secondary browser, for school and WebGL stuff
    ungoogled-chromium
    # chat
    discord
    # meetings
    zoom-us
    # screen recording
    obs-studio
    # volume
    pavucontrol
    # compile
    gcc
    # seriously?
    unzip
    # reverse engineering
    ghidra-bin
    # git GUI
    lazygit
    # video player
    mpv
    # music
    spotify
    # flex
    neofetch
    # VMs
    virt-manager
  ];
}
