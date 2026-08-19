# `nix fmt` provides one reproducible formatting and static-analysis entrypoint.
{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      nixfmt.enable = true;
      deadnix.enable = true;
      statix.enable = true;
    };
  };
}
