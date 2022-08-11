{pkgs, ...}: {
  home.packages = [pkgs.fcitx5 pkgs.fcitx-engines.libpinyin];
}
