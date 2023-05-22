{ pkgs, ... }:
# I always need python available offline. Essential for scripting.
{
  home.packages = [ (pkgs.python3.withPackages (ppkgs: [ ppkgs.black ])) ];
}
