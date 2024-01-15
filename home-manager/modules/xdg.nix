{ config, ... }:
# https://github.com/LunNova/nixos-configs/blob/4f8cd98af25c7a1cd20d62af602c393d3ce66a65/users/lun/xdg-mime-apps.nix#L3-L23
let
  browser = [
    "firefox.desktop" # assume firefox provides this
  ];
  associations = {
    # "inode/directory" = [ "org.kde.dolphin.desktop" ];
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
  };
in
{
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = associations;
  xdg.mimeApps.defaultApplications = associations;

  # xdg.portal.enable = true;
  # xdg.portal.xdgOpenUsePortal = true;
  # xdg.desktopEntries =
  #   if config.programs.alacritty.enable
  #   then {
  #     alacritty-cat = {
  #       name = "Alacritty Cat";
  #       genericName = "Text Viewer";
  #       exec = "firefox %U";
  #       terminal = false;
  #       categories = [ "Application" "Network" "WebBrowser" ];
  #       mimeType = [ "text/html" "text/xml" ];
  #     };
  #   }
  #   else { };
}
