{ pkgs, ... }:
{
  i18n.inputMethod = {
    # https://github.com/NixOS/nixpkgs/issues/454887
    # enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-chinese-addons ];
  };
}
