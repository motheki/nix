{
  description = "mothkeki's system flake";

  inputs = {
    nixpkgs = {url = "github:nixos/nixpkgs/master";};
    determinate = {url = "github:DeterminateSystems/determinate/main";};
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {url = "github:zhaofengli-wip/nix-homebrew/main";};
  };

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    determinate,
    ...
  } @ inputs: {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    darwinConfigurations = {
      "mothekis-macbook-pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          determinate.darwinModules.default
          ./nix-darwin
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "motheki";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              users.motheki = import ./home;
            };
          }
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
    homeConfigurations = {
      "motheki@mothekis-macbook-pro" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
        ];
      };
    };
  };
}
