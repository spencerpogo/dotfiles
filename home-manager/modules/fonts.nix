{ pkgs, ... }: {
  # enable nix managaing fonts (some GUI modules such as vscode and gnome-terminal need
  #  them)
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.meslo-lg
    pkgs.nerd-fonts.symbols-only
    pkgs.font-awesome_5
  ];
}
