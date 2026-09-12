# Explicit applications compiled from the shared Nix command specifications.
{
  config,
  den,
  lib,
  ...
}: let
  hostName = lib.head (builtins.attrNames config.flake.darwinConfigurations);
in {
  perSystem = {pkgs, ...}: let
    flakeFilePackages = lib.mapAttrs (_: app: app pkgs) config.flake-file.apps;
  in {
    # Keep the public package surface explicit. Devenv's flake module otherwise
    # contributes deprecated *-devenv-{up,test} compatibility packages.
    packages = lib.mkForce (
      flakeFilePackages
      // den.lib.nh.denPackages {fromFlake = true;} pkgs
      // (import ./_lib/command-apps.nix {inherit lib pkgs hostName;})
      // {
        dependency-manifest = pkgs.writeText "dependencies.json" (builtins.toJSON config.flake.lib.dependencyManifest);
        # Compatibility with the former aggregate command name. flake-file's
        # canonical writer already regenerates flake.nix and runs write hooks.
        write-all = flakeFilePackages.write-flake;
      }
    );
  };
}
