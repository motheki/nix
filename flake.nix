{
  description = "Motheki's Home Manager Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {inherit system;};
  in {
    homeConfigurations = {
      motheki = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
