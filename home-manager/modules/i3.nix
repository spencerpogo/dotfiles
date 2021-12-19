{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  esc = v: ''"${v}"'';

  lmonitor = "DVI-D-0";
  rmonitor = "HDMI-A-0";

  ws0 = esc "0:"; # discord
  ws1 = esc "1:"; # firefox
  ws2 = esc "2:"; # terminals
  ws3 = esc "3:"; # editor
  ws4 = esc "4";
  ws5 = esc "5";
  ws6 = esc "6";
  ws7 = esc "7";
  ws8 = esc "8:"; # steam
  ws9 = esc "9:"; # game
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

  programs.i3status-rust = {
    enable = true;
    bars.bottom = {
      theme = "nord-dark";
      icons = "awesome5";
      blocks = [
        {
          block = "disk_space";
          path = "/";
          alias = "/";
          info_type = "available";
          unit = "GB";
          interval = 15;
          warning = 20.0;
          alert = 10.0;
        }
        {
          block = "memory";
          display_type = "memory";
          format_mem = "{mem_used_percents}";
          format_swap = "{swap_used_percents}";
          interval = 5;
        }
        {
          block = "cpu";
          interval = 5;
        }
        {
          block = "load";
          interval = 5;
          format = "{1m}";
        }
        { block = "sound"; }
        {
          block = "time";
          interval = 1;
          format = "%a %m/%d %r";
        }
      ];
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod; # super

      keybindings = lib.mkOptionDefault {
        "${mod}+n" = "move workspace to output left";
        "${mod}+m" = "move workspace to output right";

        "${mod}+0" = "workspace number ${ws0}";
        "${mod}+1" = "workspace number ${ws1}";
        "${mod}+2" = "workspace number ${ws2}";
        "${mod}+3" = "workspace number ${ws3}";
        "${mod}+4" = "workspace number ${ws4}";
        "${mod}+5" = "workspace number ${ws5}";
        "${mod}+6" = "workspace number ${ws6}";
        "${mod}+7" = "workspace number ${ws7}";
        "${mod}+8" = "workspace number ${ws8}";
        "${mod}+9" = "workspace number ${ws9}";

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

        "${mod}+Shift+p" = "exec --no-startup-id ${pkgs.i3lock}/bin/i3lock";

        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
      };

      assigns = builtins.listToAttrs [
        {
          name = ws0;
          value = [{ class = "^discord$"; }];
        }
        {
          name = ws2;
          value = [{ class = "^Alacritty$"; }];
        }
        {
          name = ws3;
          value = [{ class = "^VSCodium$"; }];
        }
        {
          name = ws4;
          value = [{ class = "^zoom$"; }];
        }
        {
          name = ws8;
          value = [{ class = "^Steam$"; }];
        }
        {
          name = ws9;
          value = [ { class = "^csgo_linux64$"; } { class = "^factorio$"; } ];
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
        statusCommand =
          "${config.programs.i3status-rust.package}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-bottom.toml";
        fonts = {
          # Monospace still makes fontwawesome fonts work
          # putting fontawesome as the font face makes colons off-center
          names = [ "monospace" ];
          size = 10.0;
        };
        trayOutput = "primary";
        colors = {
          background = "#2e3440";
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
      workspace ${ws0} output ${lmonitor}
      workspace ${ws1} output ${rmonitor}
      workspace ${ws2} output ${rmonitor} layout tabbed
      workspace ${ws8} output ${rmonitor}
      workspace ${ws9} output ${rmonitor}

      for_window [class="^Firefox$"] move to workspace ${ws1}
    '';
  };
}
