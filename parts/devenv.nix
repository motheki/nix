{inputs, ...}: {
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem = _: {
    devenv.shells.default = {
      name = "home-manager-flake";
      git-hooks.hooks = {
        treefmt.enable = true;
        statix.enable = true;
        deadnix.enable = true;
      };
    };
  };
}
