# Reusable devenv modules supply the toolchains; flake-parts exposes the shells.
{inputs, ...}: {
  imports = [inputs.devenv.flakeModule];

  perSystem = {config, ...}: {
    devenv.shells = {
      default = {
        imports = [./_modules/devenv/default.nix];
        packages = [config.treefmt.build.wrapper];
      };
      mobile.imports = [./_modules/devenv/mobile.nix];
      systems.imports = [./_modules/devenv/systems.nix];
    };
  };
}
