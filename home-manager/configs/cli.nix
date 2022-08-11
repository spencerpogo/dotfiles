{pkgs, ...}:
# Minimal CLI setup: shells and a couple essential tools.
{
  imports = [
    ../modules/bash.nix
    ../modules/zsh/zsh.nix
    ../modules/git.nix
    ../modules/direnv.nix
  ];

  # Shell tools
  home.packages = with pkgs; [ripgrep nixfmt];

  programs = {
    bat.enable = true;
    jq.enable = true;
  };
}
