{
  description = "Motheki's declarative macOS configuration";

  inputs = {
    brew-src = {
      url = "github:Homebrew/brew/7.0.10";
      flake = false;
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    den.url = "github:denful/den/main";
    devenv = {
      url = "github:cachix/devenv";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask/main";
      flake = false;
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core/main";
      flake = false;
    };
    import-tree.url = "github:denful/import-tree/main";
    llm-agents = {
      url = "github:numtide/llm-agents.nix/main";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew/main";
      inputs.brew-src.follows = "brew-src";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.den.flakeModule
        inputs.devenv.flakeModule
        inputs.treefmt-nix.flakeModule
        (inputs.import-tree ./modules)
      ];
      perSystem = _: {
        devenv.modules = [
          ({pkgs, ...}: {
            packages = with pkgs; [
              nixd
              alejandra
              statix
              deadnix
              jq
              nh
              hyperfine
            ];
          })
        ];
        devenv.shells.default = {
          name = "nix-config";
          apple.sdk = null;
          env.NIX_CONFIG_SHELL = "nix-config";
          treefmt = {
            enable = true;
            config = {
              projectRootFile = "flake.nix";
              programs = {
                alejandra.enable = true;
                deadnix.enable = true;
                statix.enable = true;
                mdformat.enable = true;
              };
            };
          };
        };
      };
    };
}
