{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ cargo rustc ];

  home.sessionPath = [ "${config.home.homeDirectory}/.cargo/bin" ];
}