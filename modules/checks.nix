# Build the actual Den configurations, including integrated Home Manager.
{
  self,
  lib,
  ...
}: {
  perSystem = {system, ...}: {
    checks =
      lib.mapAttrs' (name: host:
        lib.nameValuePair "darwin-${name}" host.system)
      (lib.filterAttrs (_: host: host.pkgs.stdenv.hostPlatform.system == system)
        self.darwinConfigurations);
  };
}
