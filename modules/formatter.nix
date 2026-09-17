# One formatter/check configuration for the Nix and Markdown sources.
{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      alejandra.enable = true;
      deadnix.enable = true;
      mdformat.enable = true;
      statix.enable = true;
    };
  };
}
