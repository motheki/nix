# Explicit applications compiled from the shared Nix command specifications.
{
  config,
  den,
  lib,
  ...
}: let
  hostName = lib.head (builtins.attrNames config.flake.darwinConfigurations);
in {
  perSystem = {pkgs, ...}: {
    packages =
      den.lib.nh.denPackages {fromFlake = true;} pkgs
      // (import ./_lib/command-apps.nix {inherit lib pkgs hostName;})
      // {
        dependency-manifest = pkgs.writeText "dependencies.json" (builtins.toJSON config.flake.lib.dependencyManifest);
      };
  };
}
