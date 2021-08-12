{ pkgs, ... }: {
  home.packages = with pkgs; [
    xcolor
    obsidian
    ungoogled-chromium
    discord
    xclip # for copying from command line
  ];

  fonts.fontconfig.enable = true;

  home.keyboard.options = [ "caps:escape_shifted_capslock" ];
}
