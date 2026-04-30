{
  description = "Motheki's Home Manager Nix Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    brew-nix = {
      url = "github:BatteredBunny/brew-nix/main";
    };
    brew-api = {
      url = "github:motheki/brew-api/main";
      flake = false;
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./parts);
}
