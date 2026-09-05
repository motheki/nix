# flake-file owns the generated entry point; Den owns host/user composition.
{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.den.flakeModule
  ];

  flake-file = {
    description = "Motheki's declarative macOS configuration";
    formatter = pkgs: pkgs.alejandra;
  };
}
