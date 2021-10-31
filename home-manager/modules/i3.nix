{ config, lib, pkgs, ... }:

let mod = "Mod4";
in {
  # Start i3 from home-manager
  # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
    # https://github.com/flameshot-org/flameshot/issues/168#issuecomment-377851744
    windowManager.command = lib.mkForce
      "${pkgs.dbus}/bin/dbus-launch ${config.xsession.windowManager.i3.package}/bin/i3";
  };

  home.packages = [ pkgs.dmenu pkgs.i3status pkgs.i3lock ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod; # super
      keybindings = lib.mkOptionDefault {
        "${mod}+n" = "move workspace to output left";
        "${mod}+m" = "move workspace to output right";

        # vim keybindings
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
      };
      startup = [{
        command =
          "xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --primary --mode 1920x1080 --pos 1440x0 --rotate normal --output DVI-D-0 --mode 1440x900 --pos 0x180 --rotate normal";
      }];
      window.hideEdgeBorders = "both";
      workspaceAutoBackAndForth = true;
      terminal = if config.programs.alacritty.enable then
        "${config.programs.alacritty.package}/bin/alacritty"
      else
        "i3-sensible-terminal";
    };
  };
}
