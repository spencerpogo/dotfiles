{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = config.home.sessionVariables.SHELL;
    # Must be (screen|tmux)(-256color)?
    terminal = "screen-256color";
    keyMode = "vi";
  };
}
