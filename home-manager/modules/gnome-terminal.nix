{ config, pkgs, ... }:

{
  home.packages = [
    # powerlevel10k recommended font
    (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  programs.gnome-terminal = {
    enable = true;
    profile = {
      "ab99b254-6e47-4d5c-affb-4b757409a868" = {
        visibleName = "Main";
        default = true;
        font = "MesloLGS Nerd Font 12";
        cursorShape = "ibeam";
        cursorBlinkMode = "on";
        colors = {
          backgroundColor = "#23262e";
          foregroundColor = "#f2f2f2";
          palette = [
            "#333333"
            "#cc0000"
            "#4e9a06"
            "#c4a000"
            "#3465a4"
            "#75507b"
            "#06989a"
            "#d3d7cf"
            "#88807c"
            "#f15d22"
            "#73c48f"
            "#ffce51"
            "#48b9c7"
            "#ad7fa8"
            "#34e2e2"
            "#eeeeec"
          ];
          highlight = {
            background = "#48b9c7";
            foreground = "#ffffff";
          };
        };
        customCommand = if config.programs.zsh.enable then "${pkgs.zsh}/bin/zsh -i" else null;
      };
    };
  };

  # Non-nixos: Don't install gnome-terminal with nix
  # https://github.com/nix-community/home-manager/issues/2143#issuecomment-869095788
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome // {
        gnome-terminal = super.writeShellScriptBin "dummy-gnome-terminal"
          "exec /usr/bin/env gnome-terminal";
      };
    })
  ];
}
