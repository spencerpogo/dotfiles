{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS Nerd Font";
      size = 11.5;
    };
    themeFile = "Obsidian";
    settings = {
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      close_on_child_death = "yes";
      shell =
        if config.programs.tmux.enable
        then "${pkgs.runtimeShell} -c 'tmux attach || tmux new'"
        else ".";
      update_check_interval = 0;
    };
  };
}
