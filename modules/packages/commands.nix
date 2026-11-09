# Add Den's native nh commands.
# Do not force the package set: other modules can publish reusable tools.
{den, ...}: {
  perSystem = {pkgs, ...}: {
    packages = den.lib.nh.denPackages {fromFlake = true;} pkgs;
  };
}
