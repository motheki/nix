# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Motheki's declarative macOS configuration";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    apple-simutil = {
      url = "github:wix/homebrew-brew/master";
      flake = false;
    };
    brew-src = {
      url = "github:Homebrew/brew/main";
      flake = false;
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    den.url = "github:denful/den/main";
    fff-mcp = {
      url = "github:dmtrKovalenko/homebrew-fff/main";
      flake = false;
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    hax = {
      url = "github:OleksandrChekhovskyi/homebrew-hax/master";
      flake = false;
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
    llm-agents.url = "github:numtide/llm-agents.nix/main";
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew/main";
      inputs.brew-src.follows = "brew-src";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-lib.follows = "nixpkgs";
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
