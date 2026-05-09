{
  description = "Motheki's Home Manager Nix Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
    };
    den = {
      url = "github:denful/den/main";
    };
    import-tree = {
      url = "github:denful/import-tree/main";
    };
    nur = {
      url = "github:nix-community/NUR/main";
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew/main";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core/main";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask/main";
      flake = false;
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util/master";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./parts);
}
