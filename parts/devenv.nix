{ inputs, ... }:
{
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem = _: {
    devenv.shells.default = {
      treefmt = {
        enable = true;
        config.programs = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
      };

      git-hooks.hooks = {
        treefmt.enable = true;
        statix.enable = true;
        deadnix.enable = true;
      };
    };
  };
}
