{ pkgs, ... }:

{
  systemd.user.services = [{
    Unit = {
      Description = "Intelligent Input Bus";
      Documentation = "man:ibus-daemon(1)";
    };

    Service = {
      Environment = "DISPLAY=%I";
      ExecStart = "/usr/bin/ibus-daemon --daemonize --xim --replace";
      ExecReload = "/usr/bin/ibus restart";
      ExecStop = "/usr/bin/ibus exit";
    };

    Install = { WantedBy = "default.target"; };
  }];

  dconf.settings."desktop/ibus" = {
    "general/preload-engines" = [ "xkb:us::eng" "libpinyin" ];
    # i3 already uses Super+space
    "hotkey/triggers" = [ "<Super><Shift>space" ];
  };
}
