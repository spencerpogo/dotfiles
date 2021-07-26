{ pkgs, ... }:

{
  imports = [ ./modules/bash.nix ./modules/zsh.nix ./modules/git.nix ];

  home.packages = with pkgs; [ ripgrep nixfmt vim ];

  programs = {
    bat.enable = true;
    jq.enable = true;
  };
}
