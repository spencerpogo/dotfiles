{ pkgs, ... }:

# My VM used for pentesting/CTF playing running parrot linux (because
#  that is what is cool these days *eyeroll*)
{
  imports = [
    ./modules/base.nix
    ./modules/cli.nix
    ./modules/python.nix
    ./modules/vscode.nix
    ./modules/firefox.nix
    ./modules/guiutils.nix
    ./modules/tmux.nix
    ./modules/gnome-terminal.nix
  ];
}
