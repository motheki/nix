# One formatter/check configuration for the Nix and Markdown sources.
{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem.treefmt = import ./_modules/treefmt.nix;
}
