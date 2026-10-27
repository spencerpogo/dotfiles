{ pkgs, ... }:
# Minimal CLI setup: shells and a couple essential tools.
{
  imports = [
    ./base.nix
    ../modules/bash.nix
    ../modules/zsh/zsh.nix
    ../modules/git.nix
    ../modules/direnv.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };
}
