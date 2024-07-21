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
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR/master";
    };
  };

  outputs = {self, nixpkgs, nix-darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask, nixvim, ... }@inputs: 
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
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              users.motheki = import ./home;
            };
          }
          nixvim.nixDarwinModules.nixvim {
            programs.nixvim = {
              enable = true;
            };
          }
        ];
      };
    };
  };
}
