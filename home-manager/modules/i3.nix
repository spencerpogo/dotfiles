{ config, lib, pkgs, ... }:

let mod = "Mod4";
in {
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod; # super
      keybindings = lib.mkOptionDefault {
        "${mod}+n" = "move workspace to output left";
        "${mod}+m" = "move workspace to output right";

        # why are these not default?
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
      };
      startup = [{
        command =
          "xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --mode 1920x1080 --pos 1440x0 --rotate normal --output DVI-D-0 --mode 1440x900 --pos 0x180 --rotate normal";
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
