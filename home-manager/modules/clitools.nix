{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip # for copying from command line
  ];
}
