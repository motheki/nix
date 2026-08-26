# Declarative flake inputs. Run `nix run .#write-flake` after editing this file;
# flake-file will regenerate the small root flake without hand-maintained wiring.
{
  flake-file.inputs = {
    # All module systems share one Nixpkgs revision.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-lib.follows = "nixpkgs";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    import-tree.url = "github:denful/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-file.url = "github:denful/flake-file";
    den.url = "github:denful/den";

    # Feature flakes provide modules or packages consumed by Home Manager.
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";

    # nix-homebrew owns the Homebrew installation; these non-flake inputs pin
    # the taps that nix-darwin uses for declarative formula and cask installs.
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.brew-src.follows = "brew-src";
    };
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
}
