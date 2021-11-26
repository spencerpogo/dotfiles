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
      shell.program = if config.programs.tmux.enable then
        "${pkgs.tmux}/bin/tmux"
      else
        config.home.sessionVariables.SHELL;
    };
  };
}
