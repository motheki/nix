# A single tested script backs explicit, reproducible operational entrypoints.
{
  config,
  den,
  lib,
  ...
}: let
  hostName = lib.head (builtins.attrNames config.flake.darwinConfigurations);
  manifest = config.flake.lib.dependencyManifest;
in {
  perSystem = {pkgs, ...}: {
    packages =
      den.lib.nh.denPackages {fromFlake = true;} pkgs
      // lib.genAttrs [
        "check"
        "build"
        "switch"
        "dependencies"
        "update-core"
        "update-tools"
        "update-homebrew"
        "maintenance"
        "doctor"
        "diagram"
        "benchmark"
      ] (name:
        pkgs.writeShellApplication {
          inherit name;
          runtimeInputs = with pkgs; [nix nh jq python3 coreutils diffutils];
          text = ''
            export NIX_CONFIG_HOST="''${NIX_CONFIG_HOST:-${hostName}}"
            export NIX_CONFIG_SCRIPTS=${../scripts}
            exec ${pkgs.bash}/bin/bash ${../scripts/config.sh} ${lib.escapeShellArg name} "$@"
          '';
        })
      // {
        dependency-manifest = pkgs.writeText "dependencies.json" (builtins.toJSON manifest);
      };
  };
}
