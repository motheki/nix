# Keep the public package surface to flake-file and Den's native nh wrappers.
{
  config,
  den,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages = lib.mkForce (
      builtins.mapAttrs (_: app: app pkgs) config.flake-file.apps
      // den.lib.nh.denPackages {fromFlake = true;} pkgs
    );
  };
}
