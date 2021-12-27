{ pkgs, ... }:

# My VM used for pentesting/CTF playing running parrot linux (because
#  that is what is cool these days *eyeroll*)
{
  imports = [
    ./modules/base.nix
    ./modules/cli.nix
    ./modules/tmux.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # different prefix from host machine to avoid conflict
  programs.tmux.prefix = "C-b";

  # enable non-nixos
  targets.genericLinux.enable = true;
}
