{
  config,
  pkgs,
  ...
}:

let
  shellConfig =
    if config.programs.tmux.enable then
      "${pkgs.runtimeShell} -c \"tmux attach || tmux new\""
    else
      config.home.sessionVariables.SHELL;
in
{
  imports = [ ./fonts.nix ];

  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS Nerd Font";
      size = 11.5;
    };
    themeFile = "Doom_Vibrant";

    extraConfig = ''
      shell ${shellConfig}

      # tighter line height (like alacritty)
      modify_font cell_height 90%
    '';
  };
}
