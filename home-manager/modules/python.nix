{ pkgs, ... }:

# I always need python available offline. Essential for scripting.
{
  home.packages = [ (pkgs.python39.withPackages (ppkgs: [ ppkgs.black ])) ];
}
