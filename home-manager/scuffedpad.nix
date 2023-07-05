{ lib
, pkgs
, ...
}: {
  imports = [
    ./configs/base.nix
    ./configs/cli.nix

    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
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
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  home.packages = with pkgs; [
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
    # video player
    mpv
    # music
    spotify
    # flex
    neofetch
    # search
    ripgrep
    # steno
    # plover.dev
    # json tool
    jq
    # resource usage
    htop
  ];
}
