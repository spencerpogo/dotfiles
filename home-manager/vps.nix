{
  pkgs,
  lib,
  ...
}:
# My VPS
{
  imports = [
    ./configs/cli.nix
    ./modules/tmux.nix
  ];

  # different prefix from host machine to avoid conflict
  programs.tmux.prefix = lib.mkForce "C-b";

  # enable non-nixos
  targets.genericLinux.enable = true;
}
