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
        nixPath = ["nixpkgs=flake:nixpkgs"];
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];

          extra-trusted-users = ["motheki"];
          always-allow-substitutes = true;
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.nur.overlays.default
        ];
      };

      system.stateVersion = 6;
      documentation.doc.enable = false;
      system.tools.darwin-uninstaller.enable = false;

      environment = {
        systemPackages = [pkgs.nh];
        variables.NH_DARWIN_FLAKE = "/Users/motheki/Repos/personal/nix";
      };

      security.pam.services.sudo_local.touchIdAuth = true;

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "motheki";
        autoMigrate = false;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "wix/homebrew-brew" = inputs.apple-simutil;
          "dmtrkovalenko/homebrew-fff" = inputs.fff-mcp;
        };
      };

      homebrew = {
        enable = true;
        taps = [
          "homebrew/homebrew-core"
          "homebrew/homebrew-cask"
          "wix/brew"
          "dmtrkovalenko/fff"
        ];
        enableZshIntegration = true;
        brews = [
          "cocoapods"
          "watchman"
          "pi-coding-agent"
          "wix/brew/applesimutils"
          "dmtrkovalenko/fff/fff-mcp"
          "block-goose-cli"
        ];
        greedyCasks = true;
        global = {
          autoUpdate = true;
          brewfile = false;
        };
        caskArgs = {
          appdir = "~/Applications";
          require_sha = false;
        };
        casks = [
          "android-studio-preview@canary"
          "adguard-vpn@nightly"
          "codex"
          "codex-app"
          "zoom"
          "cleanshot"
          "betterdisplay"
          "thebrowsercompany-dia"
          "daisydisk"
          "mos"
          "iina"
          "block-goose"
          "expo-orbit"
          "zen"
          "helium-browser"
          "obs"
        ];
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          extraFlags = [
            "--force-cleanup"
            "--zap"
          ];
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
}
