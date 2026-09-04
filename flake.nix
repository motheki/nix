# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Motheki's declarative macOS configuration";

  outputs = inputs: let
    flakes = inputs.omniflake.flakes;
    moduleInputs =
      inputs
      // {
        darwin = flakes."github:nix-darwin/nix-darwin";
        den = flakes."github:denful/den";
        flake-parts = flakes."github:hercules-ci/flake-parts";
        home-manager = flakes."github:nix-community/home-manager";
      };
  in
    flakes."github:hercules-ci/flake-parts".lib.mkFlake {inputs = moduleInputs;}
    (flakes."github:denful/import-tree" ./modules);

  inputs = {
    brew-src = {
      url = "github:Homebrew/brew";
      flake = false;
    };
    fff-mcp = {
      url = "github:dmtrKovalenko/homebrew-fff";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs = {
        flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
        flake-utils.inputs.systems.follows = "omniflake/systems";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
