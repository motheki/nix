{
  inputs,
  den,
  ...
}: {
  den.aspects."mothekis-macbook-pro" = {
    includes = [den.provides.hostname];

    darwin = {
      config,
      pkgs,
      ...
    }: {
      imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

      nix = {
        package = pkgs.nixVersions.latest;
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];

          extra-trusted-users = ["motheki"];
          extra-substituters = ["https://motheki.cachix.org"];
          always-allow-substitutes = true;
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [inputs.nur.overlays.default];
      };

      system.stateVersion = 6;

      environment = {
        systemPackages = [pkgs.nh];
        variables.NH_DARWIN_FLAKE = "/Users/motheki/Repos/personal/nix";
      };

      security.pam.services.sudo_local.touchIdAuth = true;

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
          "pi-coding-agent"
        ];
        greedyCasks = true;
        global = {
          brewfile = false;
        };
        caskArgs = {
          appdir = "~/Applications";
          require_sha = false;
        };
        casks = [
          "android-studio-preview@canary"
          "adguard-vpn@nightly"
          "codex-app"
          "thebrowsercompany-dia"
          "legcord"
          "linear"
          "utm"
          "zoom"
          "betterdisplay"
          "cleanshot"
          "mos"
          "zed"
          "iina"
          "codex"
          "obs"
        ];
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          extraEnv = {
            HOMEBREW_NO_ANALYTICS = "1";
            HOMEBREW_NO_ENV_HINTS = "1";
            HOMEBREW_DEVELOPER = "1";
            HOMEBREW_NO_ASK = "1";
            # Remove once Homebrew recognizes macOS 27.
            HOMEBREW_FAKE_MACOS = "26";
          };
        };
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
  };

  den.aspects.motheki.homeManager = {
    programs.nh = {
      enable = true;
      flake = "/Users/motheki/Repos/personal/nix";
      darwinFlake = "/Users/motheki/Repos/personal/nix";
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
    };
  };
}
