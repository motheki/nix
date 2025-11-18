{
  description = "Motheki's Home Manager Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/master";
    mac-app-util.url = "github:hraban/mac-app-util/master";
    nur.url = "github:nix-community/NUR/main";
    nixvim.url = "github:nix-community/nixvim/main";
    brew-nix = {
      url = "github:BatteredBunny/brew-nix/main";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api/main";
      flake = false;
    };
		stylix = {
			url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    brew-nix,
    mac-app-util,
    nur,
    nixvim,
		stylix,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        brew-nix.overlays.default
        nur.overlays.default
      ];
    };
  in {
    homeConfigurations = {
      motheki = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
					stylix.homeModules.stylix
          nixvim.homeModules.nixvim
          mac-app-util.homeManagerModules.default
          ./home.nix
        ];
      };
    };
  };
}
