{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./fonts.nix ];

  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS Nerd Font";
      size = 11.5;
    };
    themeFile = "Doom_Vibrant";
  };
}
