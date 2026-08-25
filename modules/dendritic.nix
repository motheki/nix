# Bootstrap the two module frameworks used by the repository. flake-file owns
# flake.nix, while Den turns host and user aspects into standard flake outputs.
{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

  flake-file = {
    description = "Motheki's declarative macOS configuration";
    inputs = {
      flake-file.url = lib.mkDefault "github:denful/flake-file";
      den.url = lib.mkDefault "github:denful/den";
    };
  };
}
