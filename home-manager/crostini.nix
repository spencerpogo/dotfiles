{
  pkgs,
  lib,
  ...
}:
# crostini (chromebook)
{
  imports = [./configs/base.nix ./configs/cli.nix ./modules/tmux.nix ./modules/vscode.nix];

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "${pkgs.zsh}/bin/zsh";
  };

  nix.package = pkgs.nix;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # enable non-nixos
  targets.genericLinux.enable = true;
}
