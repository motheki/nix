# Build the actual Den configurations, including integrated Home Manager.
{
  self,
  inputs,
  lib,
  ...
}: {
  perSystem = {
    system,
    pkgs,
    ...
  }: {
    checks =
      lib.mapAttrs' (name: host:
        lib.nameValuePair "darwin-${name}" host.system)
      (lib.filterAttrs (_: host: host.pkgs.stdenv.hostPlatform.system == system)
        self.darwinConfigurations)
      // {
        fx-mcp = import ../tests/fx.nix {inherit inputs pkgs;};
      };
  };
}
