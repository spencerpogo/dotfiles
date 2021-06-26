{ pkgs, ... }:

{
  home.packages = with pkgs.python39Packages; [ pkgs.python39 black ];
}
