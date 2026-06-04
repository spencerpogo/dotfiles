{
  lib,
  config,
  pkgs,
  ...
}:

let
  tmuxBin = "${lib.getBin pkgs.tmux}/bin/tmux";
  shellConfig =
    if config.programs.tmux.enable then
      "${pkgs.runtimeShell} -c \"${tmuxBin} attach || ${tmuxBin} new\""
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
      # needed on linux but looks broken on darwin
      ${lib.optionalString (!pkgs.stdenv.isDarwin) "modify_font cell_height 90%"}

      ${lib.optionalString pkgs.stdenv.isDarwin "macos_option_as_alt yes"}
    '';
  };
}
