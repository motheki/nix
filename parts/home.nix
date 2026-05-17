{ inputs, ... }:
let
  denInputs = builtins.removeAttrs inputs [ "flake-parts" ];
  denConfig =
    (inputs.nixpkgs.lib.evalModules {
      modules = [
        (inputs.import-tree ../modules)
      ];
      specialArgs = { inputs = denInputs; };
    }).config;
in
{
  flake = {
    inherit (denConfig.flake) darwinConfigurations;
  };
}
