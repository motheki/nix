{inputs, ...}: {
  imports = [
    inputs.devenv.flakeModule
  ];

  perSystem = _: {
    devenv.shells.default = {
      name = "mothekis-home-manager-flake";
    };
  };
}
