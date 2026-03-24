{inputs, ...}: {
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem = _: {
    devenv.shells.default = {
      name = "home-manager-flake";
      treefmt = {
        enable = true;
        config.programs = {
          alejandra.enable = true;
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
