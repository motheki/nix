# Foundational APIs have independently reviewable pins. OmniFlake is reserved
# for optional tools; update commands never advance both groups implicitly.
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
      omniflake = {
        url = "github:fzakaria/omniflake";
        inputs = {
          flake-parts.follows = "flake-parts";
          flake-utils.inputs.systems.follows = "omniflake/systems";
          nixpkgs.follows = "nixpkgs";
        };
      };
    };
  };
}
