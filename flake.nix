{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    plover-flake = {
      url = "github:dnaq/plover-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      #, nixpkgs-master
      home-manager,
      nur,
      plover-flake,
    }@inputs:
    let
      overlays =
        system:
        let
          pkgs-master = null; # nixpkgs-master.legacyPackages.${system};
        in
        [
          nur.overlays.default
          (self: super: {
            discord = (
              super.discord.override {
                withOpenASAR = true;
                withVencord = true;
              }
            );

            electron_25-bin = (super.electron_25-bin.overrideAttrs { meta.knownVulnerabilities = [ ]; });
            electron_25 = self.electron_25-bin;
          })
        ];
      mkHome =
        {
          config,
          system,
          username,
          extraSpecialArgs ? { },
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "21.11";
              };
              nixpkgs.overlays = (overlays system);
            }
            plover-flake.homeManagerModules.plover
            config
          ];
          inherit extraSpecialArgs;
        };
    in
    {
      homeConfigurations.crostini = mkHome {
        config = ./home-manager/crostini.nix;
        system = "x86_64-linux";
        username = "user";
      };
      homeConfigurations.parrot = mkHome {
        config = ./home-manager/parrot.nix;
        system = "x86_64-linux";
        username = "user";
      };
      homeConfigurations.redbox12 = mkHome {
        config = ./home-manager/redbox.nix;
        system = "x86_64-linux";
        username = "spencer";
      };
      homeConfigurations.laptop = mkHome {
        config = ./home-manager/laptop.nix;
        system = "x86_64-linux";
        username = "spencer";
        extraSpecialArgs = {
          system-nixos-config = self.nixosConfigurations.sppmit;
        };
      };
      homeConfigurations.scuffedpad = mkHome {
        config = ./home-manager/scuffedpad.nix;
        system = "x86_64-linux";
        username = "spencer";
      };
      homeConfigurations.vps = mkHome {
        config = ./home-manager/vps.nix;
        system = "x86_64-linux";
        username = "spencer";
      };

      nixosConfigurations.redbox12 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./nixos/redbox12/configuration.nix ];
      };
      nixosConfigurations.sppmit = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./nixos/laptop/configuration.nix ];
      };
      nixosConfigurations.scuffedpad = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./nixos/scuffedpad/configuration.nix ];
      };
    };
}
