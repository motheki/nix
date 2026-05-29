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
        enableZshIntegration = true;
        brews = [
          #"watchman"
          "pi-coding-agent"
          "watchman"
        ];
        greedyCasks = false;
        caskArgs = {
          appdir = "~/Applications";
          require_sha = false;
        };
        casks = [
          "android-studio-preview@canary"
          "adguard-vpn@nightly"
          "codex-app"
          "microsoft-teams"
          "zoom"
          "utm"
          "codex"
          "obs"
        ];
        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
          upgrade = true;
          extraEnv = {
            HOMEBREW_NO_ANALYTICS = "1";
            HOMEBREW_NO_ENV_HINTS = "1";
          };
        };
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
      };
  };
}
