{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = config.home.sessionVariables.SHELL;
    # Must be (screen|tmux)(-256color)?
    terminal = "screen-256color";
    keyMode = "vi";
    plugins = [{
      plugin = pkgs.tmuxPlugins.power-theme;
      extraConfig = "set -g @tmux_power_theme 'redwine'";
    }];
    extraConfig = ''
      # Set new panes to open in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
