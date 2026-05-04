{ inputs, ... }:
let
  denConfig =
    (inputs.nixpkgs.lib.evalModules {
      modules = [
        (inputs.import-tree ../modules)
        inputs.den.flakeOutputs.flake
      ];
      specialArgs = { inherit inputs; };
    }).config;
in
{
  flake = {
    inherit (denConfig.flake) darwinConfigurations;
  };
}
