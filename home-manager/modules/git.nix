{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";

      alias = {
        sw = "switch";
        br = "branch";
        f = "fetch";
        co = "checkout";
      };

      user.name = "Spencer Pogorzelski";
      user.email = "34356756+spencerpogo@users.noreply.github.com";
    };
  };
}
