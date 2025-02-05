{ pkgs, ... }:
# I always need python available offline. Essential for scripting.
{
  home.packages = [
    pkgs.python3
    pkgs.black
  ];
}
