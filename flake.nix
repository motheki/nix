{
  description = "mothkeki's system flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew/main";

    homebrew-core = {
      url = "github:homebrew/homebrew-core/main";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask/main";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    ...
  } @ inputs: {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    darwinConfigurations = {
      "mothekis-macbook-pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nix-darwin
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = false;
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
  };
}
