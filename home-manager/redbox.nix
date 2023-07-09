{ lib
, pkgs
, ...
}: {
  # My desktop PC, running NixOS

  imports = [
    ./configs/base.nix
    ./configs/cli.nix

    ./modules/rust.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/fcitx5.nix
    ./modules/i3/i3.nix
    ./modules/guiutils.nix
    ./modules/tmux.nix
    ./modules/gtk.nix
    ./modules/flameshot.nix
    ./modules/fonts.nix
    ./modules/alacritty.nix
    ./modules/ssh.nix
    ./modules/vim.nix
    ./modules/neovim/neovim.nix
    ./modules/udiskie.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-13.6.9" ];
  programs.command-not-found.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  programs.zsh.initExtra = "eval \"$(${pkgs.mcfly}/bin/mcfly init zsh)\"";

  home.packages = with pkgs; [
    # command-line color picker
    # xcolor
    # secondary browser, for school and WebGL stuff
    ungoogled-chromium
    # chat
    discord
    signal-desktop
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
    # video player
    mpv
    # music
    spotify
    # flex
    neofetch
    # VMs
    virt-manager
    # search
    ripgrep
    # steno
    # plover.dev
    # shell hist
    mcfly
    # json tool
    jq
    # flashcards
    anki-bin
    # nix code formatting
    alejandra
    # ebooks
    calibre
    # notes
    obsidian
  ];
}
