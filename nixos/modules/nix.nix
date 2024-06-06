{ pkgs, inputs, lib, ... }: {
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Channel compat
  # https://ayats.org/blog/channels-to-flakes/
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  environment.etc."nix/inputs/home-manager".source =
    inputs.home-manager.outPath;
  nix.nixPath = [
    "nixpkgs=/etc/nix/inputs/nixpkgs"
    "home-manager=/etc/nix/inputs/home-manager"
  ];
  nix.registry = with lib;
    mapAttrs' (name: value: nameValuePair name { flake = value; }) inputs;
}
