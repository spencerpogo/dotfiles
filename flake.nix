{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.redbox12 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./redbox12/configuration.nix ];
    };
  };
}
