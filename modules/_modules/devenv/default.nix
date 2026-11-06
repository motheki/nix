# Repository tooling only; no shell-entry scripts or implicit formatting tasks.
{
  config,
  lib,
  pkgs,
  ...
}: {
  name = lib.mkDefault "nix-config";
  stdenv = lib.mkDefault pkgs.stdenvNoCC;
  apple.sdk = lib.mkDefault null;
  packages = with pkgs; [nixd alejandra statix deadnix jq nh hyperfine];
  env.NIX_CONFIG_SHELL = config.name;
}
