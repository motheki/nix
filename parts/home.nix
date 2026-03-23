{ inputs, ... }:
{
  flake = {
    homeConfigurations = {
      motheki = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
          overlays = [
            inputs.brew-nix.overlays.default
            inputs.nur.overlays.default
          ];
        };
        modules = [
          inputs.nixvim.homeModules.nixvim
          (inputs.import-tree ../modules)
          ../home.nix
        ];
      };
    };
  };
}
