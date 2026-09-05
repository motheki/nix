# Read-only provenance and Den's actual resolution trace, evaluated on demand.
{
  inputs,
  den,
  lib,
  ...
}: let
  describe = input: {
    revision = input.rev or null;
    narHash = input.narHash or null;
    lastModified = input.lastModified or null;
  };
  optional = import ./_lib/optional-inputs.nix inputs;
in {
  flake.lib = {
    maintenancePolicy = import ./_lib/maintenance.nix;
    dependencyManifest = {
      policy = "explicit-core; optional-tools use OmniFlake default unification; nix-homebrew overrides brew-src";
      direct = lib.mapAttrs (_: describe) (builtins.removeAttrs inputs ["self"]);
      optional = lib.mapAttrs (_: describe) optional;
    };
    aspectTrace =
      map (entry: {
        inherit (entry) name parent class;
        path = lib.concatStringsSep "/" ((entry.provider or []) ++ [entry.name]);
      })
      (den.lib.capture.captureFleet {class = "darwin";}).entries;
  };
}
