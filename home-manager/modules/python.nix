{ pkgs, ... }:

{
  home.packages = with pkgs.python39Packages; [ python black ];
}
