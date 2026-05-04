{ inputs, den, ... }:
{
  den.aspects."mothekis-macbook-pro" = {
    includes = [ den.provides.hostname ];

    darwin =
      { config, pkgs, ... }:
      {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [ inputs.nur.overlays.default ];
      };

      system.stateVersion = 6;

      environment = {
        systemPackages = [ pkgs.nh ];
        variables.NH_DARWIN_FLAKE = "/Users/motheki/Repos/personal/nix";
      };

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "motheki";
        autoMigrate = true;
        mutableTaps = true;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
        };
      };

      homebrew = {
        enable = true;
        taps = builtins.attrNames config.nix-homebrew.taps;
        casks = [
          "android-studio"
          "cleanshot"
          "codex-app"
          "thebrowsercompany-dia"
        ];
        onActivation = {
          autoUpdate = true;
          cleanup = "none";
          upgrade = true;
        };
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
      };
  };
}
