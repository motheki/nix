# M1 Pro / 16 GiB. Inventory and hardware policy only; features own behavior.
{den, ...}: {
  den.aspects.mothekis-macbook-pro = {
    includes = [
      den.aspects.features.nix-policy
      den.aspects.features.homebrew
    ];
    darwin = {
      nix.settings = {
        # A conservative starting point for builds alongside IDEs/emulators.
        max-jobs = 2;
        cores = 4;
        # This administrative user already has sudo. Nix trust is root-equivalent.
        extra-trusted-users = ["motheki"];
      };
      # Opt into features.linux-builder only when Linux builds are required.
      # Preserve the existing Intel Homebrew prefix for compatibility.
      nix-homebrew.enableRosetta = true;
      system.tools.darwin-uninstaller.enable = true;
      security.pam.services.sudo_local.touchIdAuth = true;
    };
  };
}
