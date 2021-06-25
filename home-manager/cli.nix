{ pkgs, ... }:

{
  imports = [ ./modules/bash.nix ./modules/zsh.nix ];

  home.packages = with pkgs;
    [
      xclip # for copying from command line
      ripgrep
    ];

  programs = {
    bat.enable = true;
    jq.enable = true;
    htop.enable = true;
  };
}
