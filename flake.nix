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
    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
    };
    import-tree = {
      url = "github:vic/import-tree/main";
    };
    nur = {
      url = "github:nix-community/NUR/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    brew-api = {
      url = "github:motheki/brew-api/main";
      flake = false;
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./parts);
}
