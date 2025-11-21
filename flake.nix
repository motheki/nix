{
  description = "Motheki's Home Manager Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
    mac-app-util= {
			url = "github:hraban/mac-app-util/master";
			inputs.nixpkgs.follows = "nixpkgs";
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
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api/main";
      flake = false;
    };
    stylix = {
      url = "github:nix-community/stylix/master";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      brew-nix,
      mac-app-util,
      nur,
      nixvim,
      stylix,
      ...
    }:
    let
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        overlays = [
          brew-nix.overlays.default
          nur.overlays.default
        ];
      };
    in
    {
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
