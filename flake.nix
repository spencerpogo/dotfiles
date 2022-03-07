{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      username = "spencer";
    in {
      nixosConfigurations.redbox12 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./redbox12/configuration.nix ];
      };
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit system username;
        configuration = import ./home-manager/redbox.nix;
        homeDirectory = "/home/${username}";
        stateVersion = "21.11";
      };
    };
}
