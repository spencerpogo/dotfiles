{ pkgs, ... }:
# Minimal CLI setup: shells and a couple essential tools.
{
  imports = [
    ../modules/bash.nix
    ../modules/zsh/zsh.nix
    ../modules/git.nix
    ../modules/direnv.nix
  ];
}
