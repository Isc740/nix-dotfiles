{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, home-manager } @inputs: let
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };

        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.isc740 = import ./home-manager/home.nix;
            }
        ];
      };
    };
  };
}
