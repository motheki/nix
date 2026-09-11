# Read-only provenance and Den's actual resolution trace, evaluated on demand.
{
  inputs,
  config,
  den,
  lib,
  ...
}: let
  describe = input: {
    revision = input.rev or null;
    narHash = input.narHash or null;
    lastModified = input.lastModified or null;
  };
in {
  flake.lib = {
    maintenancePolicy = import ./_lib/maintenance.nix;
    commandSpecs = import ./_lib/command-specs.nix {inherit lib;};
    aspectDiagram = (import ./_lib/command-diagram.nix {inherit lib;}) config.flake.lib.aspectTrace;
    dependencyManifest = {
      policy = "all upstream sources are direct flake inputs; shared nixpkgs, flake-parts, treefmt-nix, and brew-src use follows";
      direct = lib.mapAttrs (_: describe) (builtins.removeAttrs inputs ["self"]);
    };
    aspectTrace =
      map (entry: {
        inherit (entry) name parent class;
        path = lib.concatStringsSep "/" ((entry.provider or []) ++ [entry.name]);
      })
      (den.lib.capture.captureFleet {class = "darwin";}).entries;
  };
}
