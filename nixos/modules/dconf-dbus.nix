{ ... }: {
  # Enable DConf for gtk3 applications and firefox
  programs.dconf.enable = true;
  # Needed for flameshot
  services.dbus.enable = true;
}
