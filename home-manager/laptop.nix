{ config
, lib
, pkgs
, system-nixos-config
, ...
}: {
  # my laptop, running NixOS

  imports = [
    ./configs/base.nix
    ./configs/cli.nix

    ./modules/rust.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/fcitx5.nix
    ./modules/guiutils.nix
    ./modules/tmux.nix
    # ./modules/gtk.nix
    ./modules/flameshot.nix
    ./modules/fonts.nix
    ./modules/alacritty.nix
    ./modules/ssh.nix
    ./modules/vim.nix
    ./modules/neovim/neovim.nix
    ./modules/udiskie.nix
    ./modules/xdg.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-13.6.9" ];
  nixpkgs.overlays = [
    (self: super: {
      discord =
        (super.discord.override { withOpenASAR = true; withVencord = true; vencord = "${config.home.homeDirectory}/github/vencord/dist"; });
    })
  ];
  programs.command-not-found.enable = true;

  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    windowManager.command = "startplasma-x11";
  };

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
    plover.dev
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
    # nix searching
    nix-index
    # wrapping sqlite
    rlwrap
    # sqlite
    sqlite
    # image viewer (used by i3 anyway)
    feh
    # youtube downloader
    yt-dlp
    # song metadata editor
    easytag
    # process management
    htop
    # media processing
    ffmpeg
    # steno
    (lib.hiPrio (plover-from-flake.with-plugins (ps: [ ps.plover_lapwing_aio ])))
  ];
}
