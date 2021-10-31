{ pkgs, ... }:

{
  services.flameshot = {
    settings.General = {
      disabledTrayIcon = true;
      showStartupLaunchMessage = false;
    };
  };
}
