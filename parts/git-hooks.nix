{ inputs, ... }:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];

  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        treefmt = {
          enable = true;
          package = config.treefmt.build.wrapper;
        };
        statix = {
          enable = true;
        };
        deadnix = {
          enable = true;
        };
      };

      devShells.default = pkgs.mkShell {
        shellHook = config.pre-commit.shellHook;
        packages = config.pre-commit.settings.enabledPackages;
      };
    };
}
