{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./configs/desktop.nix

    ./modules/i3/i3.nix
    ./modules/gtk.nix
  ];

  home.hasBattery = true;
}
