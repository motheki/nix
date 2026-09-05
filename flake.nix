# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Motheki's declarative macOS configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);

  inputs = {
    brew-src = {
      url = "github:Homebrew/brew";
      flake = false;
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    den.url = "github:denful/den";
    fff-mcp = {
      url = "github:dmtrKovalenko/homebrew-fff";
      flake = false;
    };
    flake-file.url = "github:denful/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    import-tree.url = "github:denful/import-tree";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs = {
        flake-parts.follows = "flake-parts";
        flake-utils.inputs.systems.follows = "omniflake/systems";
        nixpkgs.follows = "nixpkgs";
      };
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
