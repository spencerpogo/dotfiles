{
  config,
  lib,
  pkgs,
  system-nixos-config,
  ...
}:
{
  # my laptop, running NixOS

  imports = [
    ./configs/desktop.nix

    ./modules/rust.nix
    ./modules/fcitx5.nix
    ./modules/kitty.nix
    ./modules/udiskie.nix
    ./modules/xdg.nix
  ];

  programs.zsh.shellAliases = {
    paste = "wl-paste";
    pimg = "paste --type image/png";
  };

  nixpkgs.config.permittedInsecurePackages = [ "electron-13.6.9" ];
  nixpkgs.overlays = [
    (self: super: {
      discord = (
        super.discord.override {
          withOpenASAR = true;
          withVencord = true;
          vencord = "${config.home.homeDirectory}/github/vencord/dist";
        }
      );
    })
  ];
  programs.command-not-found.enable = true;

  # Plasma sources these before starting the Wayland session and imports the
  # resulting environment into its user services and D-Bus activation.
  xdg.configFile."plasma-workspace/env/10-home-manager.sh".text = ''
    . "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';

  # broken temporarily
  # programs.plover = {
  #   enable = true;
  #   package = pkgs.plover-from-flake.withPlugins (ps: with ps; [ plover-lapwing-aio ]);
  # };

  home.packages = with pkgs; [
    wl-clipboard
    # reverse engineering
    ghidra-bin
    # flashcards
    anki-bin
    # nix code formatting
    alejandra
    # ebooks
    # calibre (broken rn: nixOS/nixpkgs#348845)
    # notes
    obsidian
    # nix searching
    nix-index
    # wrapping sqlite
    rlwrap
    # sqlite
    sqlite
    # image viewer
    imv
    # youtube downloader
    yt-dlp
    # song metadata editor
    easytag
    # media processing
    ffmpeg
    # chat
    slack
    # AI
    claude-code
    codex
    antigravity-cli
  ];
}
