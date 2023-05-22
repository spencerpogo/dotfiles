{ pkgs, ... }: {
  # enable nix managaing fonts (some GUI modules such as vscode and gnome-terminal need
  #  them)
  fonts.fontconfig.enable = true;

  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        # coding font with amazing ligatures for editor
        "FiraCode"
        # Terminal font
        "Meslo"
      ];
    })
    pkgs.font-awesome_5
  ];
}
