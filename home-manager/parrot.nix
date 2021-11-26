{ pkgs, ... }:

# My VM used for pentesting/CTF playing running parrot linux (because
#  that is what is cool these days *eyeroll*)
{
  imports = [
    ./modules/base.nix
    ./modules/cli.nix
    ./modules/rust.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/guiutils.nix
    # TODO: test this and add to cli.nix or parrot.nix
    ./modules/tmux.nix
    ./modules/pentesting.nix
    ./modules/flameshot.nix
    ./modules/fonts.nix
    ./modules/alacritty.nix
  ];

  # enable non-nixos
  targets.genericLinux.enable = true;
}
