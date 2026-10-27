{
  pkgs,
  lib,
  ...
}:
# Ubuntu WSL Machine
{
  imports = [
    ./configs/cli.nix
    ./modules/tmux.nix
  ];

  # enable non-nixos
  targets.genericLinux.enable = true;
}
