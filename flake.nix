{
  description = "mothkeki's system flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew/main";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core/master";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask/master";
      flake = false;
    };
  };
  outputs = {nixpkgs, nix-darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask, ... }: 
  {
    darwinConfigurations = {
      "mothekis-macbook-pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nix-darwin
          ./homebrew
          nix-homebrew.darwinModules.nix-homebrew {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "motheki";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              verbose = true;
              users.motheki = import ./home;
            };
          }
        ];
      };
    };
  };
}
