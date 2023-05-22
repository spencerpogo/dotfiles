{ pkgs, ... }:
# Utitilities that are only useful on a GUI system
{
  home.packages = with pkgs; [
    # for copying from command line. extremely useful
    xclip
  ];
}
