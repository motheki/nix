# Dendritic wiring for flake-file and Den.
{inputs, ...}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  flake-file = {
    description = "Motheki's declarative macOS configuration";
    formatter = pkgs: pkgs.alejandra;
  };
}
