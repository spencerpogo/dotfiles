{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-master
    , home-manager
    , nur
    ,
    } @ inputs:
    let
      overlays = system:
        let
          pkgs-master = nixpkgs-master.legacyPackages.${system};
        in
        [
          nur.overlay
          (self: super: {
            # Temp Override until NixOS/nixpkgs#264407 lands in nixos-unstable
            vencord = pkgs-master.vencord;
            discord =
              (super.discord.override { withOpenASAR = true; withVencord = true; });
          })
        ];
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
              nixpkgs.overlays = (overlays system);
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
      nixosConfigurations.scuffedpad = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [ ./nixos/scuffedpad/configuration.nix ];
      };
    };
}
