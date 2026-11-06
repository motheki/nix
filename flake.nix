# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Motheki's declarative macOS configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);

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
    flake-file.url = "github:denful/flake-file/main";
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
}
