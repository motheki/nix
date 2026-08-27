# `nix fmt` provides one reproducible formatting and static-analysis entrypoint.
{inputs, ...}: {
  imports = [inputs.omniflake.flakes."github:numtide/treefmt-nix".flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      alejandra.enable = true;
      statix.enable = true;
      deadnix.enable = true;
      mdformat.enable = true;
    };
  };
}
