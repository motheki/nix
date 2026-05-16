{ inputs, den, ... }:
{
  den.aspects."mothekis-macbook-pro" = {
    includes = [ den.provides.hostname ];

    darwin =
      { config, pkgs, ... }:
      {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        extra-trusted-users = [ "motheki" ];
        extra-substituters = [ "https://motheki.cachix.org" ];
        always-allow-substitutes = true;
      };

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
        mutableTaps = false;
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
          "linear"
          "notion-enhanced"
          "adguard-vpn@nightly"
          "notion-mail"
          "notion-calendar"
          "codex-app"
          "expo-orbit"
          "chatgpt"
          "thebrowsercompany-dia"
        ];
        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
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
