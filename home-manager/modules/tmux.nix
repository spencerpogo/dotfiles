{
  config,
  pkgs,
  ...
}:
{
  programs.tmux =
    let
      prefix = "C-a";
    in
    {
      enable = true;
      inherit prefix;
      shell = config.home.sessionVariables.SHELL;
      # Must be (screen|tmux)(-256color)?
      terminal = "screen-256color";
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      extraConfig = ''
        # Prevent delay after pressing esc
        set -sg escape-time 20

        # better colors
        set -ag terminal-overrides ",alacritty:RGB"

        # Set new panes to open in current directory
        bind c new-window -c "#{pane_current_path}"
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        # ...with an escape hatch if we don't want to wait for direnv
        bind v new-window

        # Better split binds
        bind - split-window -c "#{pane_current_path}"
        bind \\ split-window -h -c "#{pane_current_path}"

        # g for git
        bind g new-window -c "#{pane_current_path}" "${pkgs.lazygit}/bin/lazygit"
        # e for editor
        bind e new-window -c "#{pane_current_path}" "codium ."

        # work around nix-community/home-manager#7771
        bind ${prefix} send-prefix
      '';
    };
}
