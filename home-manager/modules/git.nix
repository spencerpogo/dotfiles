{pkgs, ...}:
# Basic git info
{
  programs.git = {
    enable = true;
    userName = "Spencer Pogorzelski";
    userEmail = "34356756+Scoder12@users.noreply.github.com";
    # TODO: Signing
  };
}
