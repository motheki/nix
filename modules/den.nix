# Bootstrap the module frameworks used by the repository through omniflake.
# flake-file owns flake.nix, while Den turns aspects into system outputs.
{inputs, ...}: let
  flakes = inputs.omniflake.flakes;
in {
  imports = [
    flakes."github:denful/flake-file".flakeModules.default
    flakes."github:hercules-ci/flake-parts".flakeModules.modules
    flakes."github:denful/den".flakeModule
  ];

  flake-file = {
    description = "Motheki's declarative macOS configuration";
    formatter = pkgs: pkgs.alejandra;
  };
  flake.modules = {};
}
