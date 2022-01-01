{ pkgs, ... }:

# Minimal CLI setup: shells and a couple essential tools.
{
  imports = [ ./bash.nix ./zsh.nix ./git.nix ];

  # Shell tools
  home.packages = with pkgs; [ ripgrep nixfmt ];

  programs = {
    bat.enable = true;
    jq.enable = true;
  };
}
