{ pkgs, ... }:
# My VM used for pentesting/CTF playing running parrot linux (because
#  that is what is cool these days *eyeroll*)
{
  imports = [
    ./configs/base.nix
    ./configs/cli.nix

    ./modules/rust.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/guiutils.nix
    ./modules/tmux.nix
    ./modules/flameshot.nix
    ./modules/fonts.nix
    ./modules/alacritty.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # enable non-nixos
  targets.genericLinux.enable = true;

  # Non-nixos: Don't install alacritty with nix as nix libGL doesn't work very well
  # Install with cargo instead (see README.md for more information)
  # https://github.com/nix-community/home-manager/issues/2143#issuecomment-869095788
  nixpkgs.overlays = [
    (self: super: {
      alacritty = super.writeShellScriptBin "dummy-alacritty" "exec /usr/bin/env alacritty";
    })
  ];
}
