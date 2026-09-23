# Experimental devenv 2.4 build integration, with Den as the only machine source.
# No SSH destination is guessed, and HM is already embedded in the Darwin role.
{
  den,
  lib,
  ...
}: let
  hosts =
    lib.filterAttrs (_: host: host.class == "darwin")
    (lib.foldl' (acc: hosts: acc // hosts) {} (builtins.attrValues den.hosts));
  modules = lib.mapAttrs (_: host: let
    resolved = den.lib.aspects.resolveWithPaths host.class host.resolved;
  in {inherit (resolved) imports;})
  hosts;
in {
  flake.darwinModules = modules;
  perSystem = {config, ...}: {
    devenv.shells.default.machines =
      lib.mapAttrs (name: host: {
        inherit (host) system;
        nix-darwin = modules.${name};
      })
      hosts;
    # Build-only access works with the existing flake integration, whose CLI
    # shim does not implement `devenv machines`. Keep local activation with nh.
    legacyPackages.machineBuilds = lib.mapAttrs (name: _:
      config.devenv.shells.default.machines.${name}.build.nix-darwin)
    hosts;
  };
}
