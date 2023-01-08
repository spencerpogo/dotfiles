{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = "Mod4";
  esc = v: ''"${v}"'';

  outPrimary = "HDMI-A-0";
  outSecondary = "DVI-D-0";

  wallpaper =
    pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath;

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

  programs.i3status-rust = {
    enable = true;
    bars.bottom = {
      theme = "nord-dark";
      settings.icons.name = "awesome5";
      settings.icons.overrides = {
        # idk why these aren't the default
        music_prev = "玲";
        music_next = "怜";
      };
      blocks = [
        {
          block = "music";
          buttons = ["prev" "play" "next"];
          max_width = 50; # the marquee is annoying
          dynamic_width = true;
          marquee_interval = 1;
          marquee_speed = 0.15;
        }
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
        {block = "sound";}
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

        "${mod}+a" = "focus parent";
        "${mod}+b" = "focus child";

        "${mod}+Shift+p" = "exec --no-startup-id ${pkgs.i3lock}/bin/i3lock";

        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
      };

      assigns.${ws0} = [{class = "^discord$";}];
      assigns.${ws2} = [{class = "^Alacritty$";}];
      assigns.${ws3} = [{class = "^VSCodium$";}];
      assigns.${ws4} = [{class = "^zoom$";} {class = "^[cC]hromium-browser$";}];
      assigns.${ws8} = [{class = "^Steam$";}];
      assigns.${ws9} = [
        {class = "^csgo_linux64$";}
        {class = "^factorio$";}
        {class = "^portal2_linux$";}
        {class = "^Celeste";}
        {class = "^GettingOverIt.x86_64$";}
        {class = "^hollow_knight.x86_64$";}
      ];

      startup = [
        # Setup monitors
        {
          command = "xrandr --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output HDMI-A-0 --primary --mode 1920x1080 --pos 1440x0 --rotate normal --output DVI-D-0 --mode 1440x900 --pos 0x180 --rotate normal";
        }
        # Set background properly
        # its set by lightdm but glitches when i3 starts
        {
          always = true;
          command = "${pkgs.feh}/bin/feh --bg-fill ${wallpaper}";
        }
      ];

      window.hideEdgeBorders = "both";

      workspaceAutoBackAndForth = true;

      terminal =
        if config.programs.alacritty.enable
        then "${config.programs.alacritty.package}/bin/alacritty"
        else "i3-sensible-terminal";

      bars = [
        {
          position = "bottom";
          mode = "dock";
          hiddenState = "hide";
          workspaceButtons = true;
          workspaceNumbers = false;
          statusCommand = "${config.programs.i3status-rust.package}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-bottom.toml";
          fonts = {
            # Monospace still makes fontwawesome fonts work
            # putting fontawesome as the font face makes colons off-center
            names = ["monospace"];
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
        }
      ];

      colors = {
        focused = {
          background = "#ee303a";
          border = "#ff4f59";
          childBorder = "#ff4f59";
          indicator = "#b34a46";
          text = "#262626";
        };
      };
    };

    extraConfig = let
      i3r = "${pkgs.i3-resurrect}/bin/i3-resurrect";
      i3r-restore = ws: "sleep 0.1; ${i3r} restore --numeric --workspace ${builtins.toString ws}";
    in ''
      #for_window [class="^[fF]irefox$"] move --no-auto-back-and-forth to workspace ${ws1}
      for_window [class="^Spotify$"] move --no-auto-back-and-forth to workspace ${ws7}

      workspace ${ws0} output ${outSecondary}
      workspace ${ws1} output ${outPrimary}
      workspace ${ws4} output ${outSecondary}

      exec --no-startup-id "${i3r-restore 0}"
      exec --no-startup-id "${i3r-restore 1}"
      exec --no-startup-id "${i3r-restore 4}"
      exec --no-startup-id "sleep 0.2; until host example.com; do sleep 0.2; done; firefox & discord"
    '';
  };

  home.packages = [pkgs.i3-resurrect];

  xdg.configFile."i3-resurrect/config.json".text = builtins.toJSON {
    directory = "~/.i3/i3-resurrect/";
    window_command_mappings = [
      {class = "firefox";}
    ];
    window_swallow_criteria = {};
    terminals = ["Alacritty"];
  };
}
