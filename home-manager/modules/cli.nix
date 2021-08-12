{ pkgs, ... }:

{
  imports = [ ./bash.nix ./zsh.nix ./git.nix ];

  home.packages = with pkgs; [ ripgrep nixfmt vim ];

  programs = {
    bat.enable = true;
    jq.enable = true;
  };
}
