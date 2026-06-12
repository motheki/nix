{inputs, ...}: {
  imports = [
    inputs.den.flakeModule
    (inputs.import-tree ../modules)
  ];
}
