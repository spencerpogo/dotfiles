{ pkgs, ... }:

# Basic git info
{
  programs.git = {
    enable = true;
    userName = "Scoder12";
    userEmail = "34356756+Scoder12@users.noreply.github.com";
    # TODO: Signing
  };
}
