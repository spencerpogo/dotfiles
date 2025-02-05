{
  config,
  pkgs,
  ...
}:
let
  termfont = {
    family = "MesloLGS Nerd Font";
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = termfont;
        # bold = termfont;
        # italic = termfont;
        # bold_italic = termfont;
        size = 11.5;
      };

      cursor = {
        style = "Beam";
        thickness = 0.2;
      };

      terminal.shell =
        if config.programs.tmux.enable then
          {
            program = pkgs.runtimeShell;
            args = [
              "-c"
              "tmux attach || tmux new"
            ];
          }
        else
          {
            program = config.home.sessionVariables.SHELL;
          };

      colors.selection = {
        text = "#ffffff";
        background = "#48b9c7";
      };

      colors.normal = {
        black = "0x3e3e3e";
        red = "0xf81118";
        green = "0x2dc55e";
        yellow = "0xecba0f";
        blue = "0x2a84d2";
        magenta = "0x4e5ab7";
        cyan = "0x1081d6";
        white = "0xd6dbe5";
      };

      colors.bright = {
        black = "0xd6dbe5";
        red = "0xde352e";
        green = "0x1dd361";
        yellow = "0xf3bd09";
        blue = "0x1081d6";
        magenta = "0x5350b9";
        cyan = "0x0f7ddb";
        white = "0xffffff";
      };
    };
  };
}
