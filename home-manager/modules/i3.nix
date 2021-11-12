{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  esc = v: ''"${v}"'';
  ws1 = esc "1:"; # discord
  ws2 = esc "2:"; # firefox
  ws3 = esc "3:"; # terminals
  ws4 = esc "4:"; # editor
  ws5 = esc "5";
  ws6 = esc "6";
  ws7 = esc "7";
  ws8 = esc "8";
  ws9 = esc "9";
  ws0 = esc "0";
in {
  # Start i3 from home-manager
  # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
  xsession = {
    enable = true;
    scriptPath = ".hm-xsession";
  };

  home.packages = [
    pkgs.i3
    pkgs.dmenu
    pkgs.i3status
    pkgs.i3lock
    pkgs.feh
    pkgs.xorg.xrandr
    pkgs.flameshot
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod; # super

      keybindings = lib.mkOptionDefault {
        "${mod}+n" = "move workspace to output left";
        "${mod}+m" = "move workspace to output right";

        "${mod}+1" = "workspace number ${ws1}";
        "${mod}+2" = "workspace number ${ws2}";
        "${mod}+3" = "workspace number ${ws3}";
        "${mod}+4" = "workspace number ${ws4}";
        "${mod}+5" = "workspace number ${ws5}";
        "${mod}+6" = "workspace number ${ws6}";
        "${mod}+7" = "workspace number ${ws7}";
        "${mod}+8" = "workspace number ${ws8}";
        "${mod}+9" = "workspace number ${ws9}";
        "${mod}+0" = "workspace number ${ws0}";

        "${mod}+Shift+1" = "move container to workspace number ${ws1}";
        "${mod}+Shift+2" = "move container to workspace number ${ws2}";
        "${mod}+Shift+3" = "move container to workspace number ${ws3}";
        "${mod}+Shift+4" = "move container to workspace number ${ws4}";
        "${mod}+Shift+5" = "move container to workspace number ${ws5}";
        "${mod}+Shift+6" = "move container to workspace number ${ws6}";
        "${mod}+Shift+7" = "move container to workspace number ${ws7}";
        "${mod}+Shift+8" = "move container to workspace number ${ws8}";
        "${mod}+Shift+9" = "move container to workspace number ${ws9}";
        "${mod}+Shift+0" = "move container to workspace number ${ws0}";

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

      assigns = builtins.listToAttrs [
        {
          name = ws1;
          value = [{ class = "^discord$"; }];
        }
        {
          name = ws3;
          value = [{ class = "^Alacritty$"; }];
        }
        {
          name = ws4;
          value = [{ class = "^VSCodium$"; }];
        }
      ];

      startup = [
        # Setup monitors
        {
          command =
            "xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --primary --mode 1920x1080 --pos 1440x0 --rotate normal --output DVI-D-0 --mode 1440x900 --pos 0x180 --rotate normal";
        }
        # Set background properly
        # its set by lightdm but glitches when i3 starts
        {
          always = true;
          command =
            "${pkgs.feh}/bin/feh --bg-fill ${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";
        }
        { command = "${pkgs.flameshot}/bin/flameshot"; }
        { command = "${pkgs.discord}/bin/discord"; }
        { command = "${pkgs.firefox}/bin/firefox"; }
      ];

      defaultWorkspace = "workspace number ${ws2}";

      window.hideEdgeBorders = "both";

      workspaceAutoBackAndForth = true;

      terminal = if config.programs.alacritty.enable then
        "${config.programs.alacritty.package}/bin/alacritty"
      else
        "i3-sensible-terminal";

      bars = [{
        mode = "dock";
        hiddenState = "hide";
        position = "bottom";
        workspaceButtons = true;
        workspaceNumbers = false;
        statusCommand = "${pkgs.i3status}/bin/i3status";
        fonts = {
          names = [ "Font Awesome 5 Brands" ];
          size = 8.0;
        };
        trayOutput = "primary";
        colors = {
          background = "#000000";
          statusline = "#ffffff";
          separator = "#666666";
          focusedWorkspace = {
            border = "#4c7899";
            background = "#285577";
            text = "#ffffff";
          };
          activeWorkspace = {
            border = "#333333";
            background = "#5f676a";
            text = "#ffffff";
          };
          inactiveWorkspace = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
          };
          urgentWorkspace = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
          };
          bindingMode = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
          };
        };
      }];
    };
    extraConfig = ''
      workspace ${ws1} output DVI-D-0
      workspace ${ws3} output HDMI-A-0 layout tabbed

      for_window [class="^Firefox$"] move to workspace ${ws2}
    '';
  };
}
