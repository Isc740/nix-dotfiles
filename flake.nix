{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";

    fjordlauncher.url = "github:hero-persson/FjordLauncherUnlocked";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    fjordlauncher,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    packages.x86_64-linux.my-neovim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [./nvf/nvf-module.nix];
      }).neovim;

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system;};

        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.isc740 = import ./home-manager/home.nix;
          }
          ({pkgs, ...}: {
            environment.systemPackages = [
              # self.packages.${pkgs.stdenv.system}.my-neovim
              fjordlauncher.packages.${pkgs.system}.fjordlauncher
            ];
          })
        ];
      };
    };
  };
}
