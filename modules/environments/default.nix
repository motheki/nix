# One treefmt configuration serves both the shell and flake checks.
{
  perSystem = {config, ...}: {
    devenv.shells.default = {
      imports = [../_modules/devenv/default.nix];
      packages = [config.treefmt.build.wrapper];
    };
  };
}
