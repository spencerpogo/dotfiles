{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip # for copying from command line
  ];

  programs = {
    bat.enable = true;
    jq.enable = true;
    htop.enable = true;
  };
}
