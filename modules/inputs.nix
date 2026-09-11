# Every upstream source is a direct, floating flake input. flake.lock provides
# reproducibility; the update commands decide which reviewed pins to advance.
{
  flake-file = {
    outputs = ''
      inputs:
      inputs.flake-parts.lib.mkFlake { inherit inputs; }
        (inputs.import-tree ./modules)
    '';

    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      darwin = {
        url = "github:nix-darwin/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      den.url = "github:denful/den";
      devenv = {
        url = "github:cachix/devenv";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          flake-parts.follows = "flake-parts";
          nixd.inputs.treefmt-nix.follows = "treefmt-nix";
        };
      };
      flake-file.url = "github:denful/flake-file";
      import-tree.url = "github:denful/import-tree";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs";
      };
      nixvim = {
        url = "github:nix-community/nixvim";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          flake-parts.follows = "flake-parts";
        };
      };
      treefmt-nix = {
        url = "github:numtide/treefmt-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Keep externally packaged tools visible in this repository's lock graph.
      # Following the shared inputs makes a nixpkgs/tool update coherent.
      llm-agents = {
        url = "github:numtide/llm-agents.nix";
        inputs = {
          flake-parts.follows = "flake-parts";
          nixpkgs.follows = "nixpkgs";
          treefmt-nix.follows = "treefmt-nix";
        };
      };

      # Homebrew and all immutable taps are direct inputs for the same reason.
      brew-src = {
        url = "github:Homebrew/brew";
        flake = false;
      };
      nix-homebrew = {
        url = "github:zhaofengli/nix-homebrew";
        inputs.brew-src.follows = "brew-src";
      };
      homebrew-core = {
        url = "github:Homebrew/homebrew-core";
        flake = false;
      };
      homebrew-cask = {
        url = "github:Homebrew/homebrew-cask";
        flake = false;
      };
      fff-mcp = {
        url = "github:dmtrKovalenko/homebrew-fff";
        flake = false;
      };
    };
  };
}
