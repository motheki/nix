# Expose one nh-backed package per Den host/home. For this repository,
# `nix run .#mothekis-macbook-pro -- switch` builds and activates the Mac.
{ den, ... }: {
  perSystem = { pkgs, ... }: {
    packages = den.lib.nh.denPackages { fromFlake = true; } pkgs;
  };
}
