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

        # tmux 3.8 themes replace the terminal's green with a built-in shade.
        # Use the terminal palette, as older tmux versions did.
        set -s theme terminal

        # Set split panes to open in current directory
        # ...but not for new-window (c), we can break-pane if we want that behavior
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
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
