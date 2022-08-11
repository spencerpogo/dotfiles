{
  pkgs,
  lib,
  ...
}:
# Ubuntu WSL Machine
{
  imports = [./configs/base.nix ./configs/cli.nix ./modules/tmux.nix];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # enable non-nixos
  targets.genericLinux.enable = true;
}
