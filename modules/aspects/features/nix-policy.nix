# Shared daemon policy. Hardware concurrency belongs to the host aspect.
{
  den.aspects.features.nix-policy.darwin = {
    nix.settings = {
      # auto-allocate-uids is needed by this installation's dynamic build users.
      # CA derivations and Linux cgroups are not needed by this Darwin host.
      experimental-features = ["nix-command" "flakes" "auto-allocate-uids"];
      always-allow-substitutes = true;
      auto-optimise-store = false;
      # Nix's default cache.nixos.org remains enabled. Keep additional trust
      # limited to providers actually used by the selected packages.
      extra-substituters = [
        "https://cache.numtide.com"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
