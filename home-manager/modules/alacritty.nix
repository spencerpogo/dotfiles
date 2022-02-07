{ config, pkgs, ... }:

let termfont = { family = "MesloLGS Nerd Font"; };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      fonts = {
        normal = termfont;
        bold = termfont;
        italic = termfont;
        bold_italic = termfont;
        size = "12";
      };

      cursor = {
        style = "Beam";
        thickness = 0.2;
      };

      shell = if config.programs.tmux.enable then {
        program = pkgs.runtimeShell;
        args = [ "-c" "tmux attach || tmux new" ];
      } else {
        program = config.home.sessionVariables.SHELL;
      };

      colors.selection = {
        text = "#ffffff";
        background = "#48b9c7";
      };

      colors.normal = {
        black = "#333333";
        red = "#cc0000";
        green = "#4e9a06";
        yellow = "#c4a000";
        blue = "#3465a4";
        magenta = "#75507b";
        cyan = "#06989a";
        white = "#d3d7cf";
      };

      colors.bright = {
        black = "#88807c";
        red = "#f15d22";
        green = "#73c48f";
        yellow = "#ffce51";
        blue = "#48b9c7";
        magenta = "#ad7fa8";
        cyan = "#34e2e2";
        white = "#eeeeec";
      };
    };
  };
}
