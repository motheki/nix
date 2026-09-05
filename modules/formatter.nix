# `nix fmt` provides one reproducible formatting and static-analysis entrypoint.
{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      alejandra.enable = true;
      statix.enable = true;
      deadnix.enable = true;
      mdformat.enable = true;
      shellcheck.enable = true;
      shfmt.enable = true;
      ruff-check.enable = true;
      ruff-format.enable = true;
    };
  };
}
