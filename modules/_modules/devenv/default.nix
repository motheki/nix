# Repository tooling only; no shell-entry scripts or implicit formatting tasks.
{pkgs, ...}: {
  name = "nix-config";
  stdenv = pkgs.stdenvNoCC;
  apple.sdk = null;
  packages = with pkgs; [nixd alejandra statix deadnix jq nh hyperfine direnv];
  env.NIX_CONFIG_SHELL = "nix-config";
}
