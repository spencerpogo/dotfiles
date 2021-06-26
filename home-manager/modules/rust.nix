{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ cargo rustc rustfmt ];

  home.sessionPath = [ "${config.home.homeDirectory}/.cargo/bin" ];
}
