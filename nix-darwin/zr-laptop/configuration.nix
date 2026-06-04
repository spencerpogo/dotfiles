{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  time.timeZone = "America/New_York";

  environment.systemPackages = [
    pkgs.wget
    pkgs.htop
  ];

  environment.pathsToLink = [
    "/libexec" # links /libexec from derivations to /run/current-system/sw
    "/share/zsh" # zsh completions for commands
  ];

  programs.nix-index.enable = true;

  fonts.packages = [
    pkgs.nerd-fonts.meslo-lg
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # Channel compat
  # https://ayats.org/blog/channels-to-flakes/
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  environment.etc."nix/inputs/home-manager".source = inputs.home-manager.outPath;
  nix.nixPath = [
    "nixpkgs=/etc/nix/inputs/nixpkgs"
    "home-manager=/etc/nix/inputs/home-manager"
  ];
  nix.registry = with lib; mapAttrs' (name: value: nameValuePair name { flake = value; }) inputs;

  system.stateVersion = 7;
}
