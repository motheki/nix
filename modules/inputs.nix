# Declarative flake inputs. Run `nix run .#write-flake` after editing this file;
# flake-file will regenerate the small root flake without hand-maintained wiring.
{
  flake-file = {
    # Den expects these names in the module input set. They are OmniFlake-backed
    # values, not direct inputs, so they add no nodes to this repository's lock.
    outputs = ''
      inputs:
      let
        flakes = inputs.omniflake.flakes;
        moduleInputs = inputs // {
          darwin = flakes."github:nix-darwin/nix-darwin";
          den = flakes."github:denful/den";
          flake-parts = flakes."github:hercules-ci/flake-parts";
          home-manager = flakes."github:nix-community/home-manager";
        };
      in
      flakes."github:hercules-ci/flake-parts".lib.mkFlake { inputs = moduleInputs; }
        (flakes."github:denful/import-tree" ./modules)
    '';

    inputs = {
      # OmniFlake substitutes this revision into indexed flakes that expose a
      # conventional nixpkgs input.
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      omniflake = {
        url = "github:fzakaria/omniflake";
        inputs = {
          flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
          flake-utils.inputs.systems.follows = "omniflake/systems";
          nixpkgs.follows = "nixpkgs";
        };
      };

      # OmniFlake indexes flakes only. These repositories are source trees used
      # by nix-homebrew and nix-darwin, so they remain direct non-flake inputs.
      brew-src = {
        url = "github:Homebrew/brew";
        flake = false;
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
