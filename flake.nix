{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nur
    ,
    } @ inputs:
    let
      mkHome =
        { config
        , system
        , username
        ,
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
              nixpkgs.overlays = [
                nur.overlay
              ];
            }
            config
          ];
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
    };
}
