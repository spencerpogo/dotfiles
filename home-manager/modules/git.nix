{ pkgs, ... }:
# Basic git info
{
  programs.git = {
    enable = true;
    userName = "Spencer Pogorzelski";
    userEmail = "34356756+spencerpogo@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      sw = "switch";
      br = "branch";
      f = "fetch";
      co = "checkout";
    };
    # TODO: Signing
  };
}
