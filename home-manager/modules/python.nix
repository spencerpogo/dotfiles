{ pkgs, ... }:

# I always need python available offline. Essential for scripting.
{
  home.packages = with pkgs.python39Packages; [
    python.withPackages
    (ppkgs: [ ppkgs.black ])
  ];
}
