# Dendritic wiring for flake-file and Den.
{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

  flake-file = {
    description = "Motheki's declarative macOS configuration";
    formatter = pkgs: pkgs.alejandra;
  };
}
