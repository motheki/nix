# Native devenv entry point; Home Manager supplies the CLI and shell hooks.
{
  inputs,
  pkgs,
  ...
}: let
  treefmt = inputs.treefmt-nix.lib.evalModule pkgs ./modules/_modules/treefmt.nix;
in {
  imports = [./modules/_modules/devenv/default.nix];

  profiles.systems.module.imports = [./modules/_modules/devenv/systems.nix];

  # Expose the formatter without running it automatically on shell entry.
  packages = [treefmt.config.build.wrapper];
}
