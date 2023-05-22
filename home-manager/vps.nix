{ pkgs
, lib
, ...
}:
# My VPS
{
  imports = [ ./configs/base.nix ./configs/cli.nix ./modules/tmux.nix ];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  # different prefix from host machine to avoid conflict
  programs.tmux.prefix = lib.mkForce "C-b";

  # enable non-nixos
  targets.genericLinux.enable = true;
}
