# Machine-specific nix-darwin configuration. Den associates this aspect with
# the host of the same name declared in modules/hosts.nix.
{ inputs, ... }: {
  den.aspects.mothekis-macbook-pro.darwin =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

      nix = {
        package = pkgs.nixVersions.latest;
        linux-builder = {
          enable = true;
          systems = [
            "aarch64-linux"
            "x86_64-linux"
          ];
        };
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          extra-trusted-users = [ "motheki" ];
          always-allow-substitutes = true;
          extra-substituters = [ "https://cache.numtide.com" ];
          extra-trusted-public-keys = [
            "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
          ];
        };
      };

      system.tools.darwin-uninstaller.enable = true;
      security.pam.services.sudo_local.touchIdAuth = true;

      # Home Manager owns completion and Starship owns the prompt. Keep the
      # system Zsh module from initializing either one a second time.
      programs.zsh = {
        enableGlobalCompInit = false;
        promptInit = "";
      };

      # nix-homebrew pins and owns Homebrew itself. nix-darwin, below, owns
      # the declarative Brewfile of formulae and applications.
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        enableZshIntegration = true;
        user = "motheki";
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "wix/homebrew-brew" = inputs.apple-simutil;
          "dmtrkovalenko/homebrew-fff" = inputs.fff-mcp;
          "oleksandrchekhovskyi/homebrew-hax" = inputs.hax;
        };

        # Trust only the third-party formulae that this configuration installs,
        # rather than granting every present and future formula in each tap.
        trust.formulae = [
          "wix/brew/applesimutils"
          "dmtrkovalenko/fff/fff-mcp"
          "oleksandrchekhovskyi/hax/hax"
        ];
      };

      homebrew = {
        enable = true;
        taps = builtins.attrNames config.nix-homebrew.taps;

        # nix-homebrew emits shellenv once for both native and Rosetta prefixes.
        enableZshIntegration = false;
        brews = [
          "cocoapods"
          "watchman"
          "wix/brew/applesimutils"
          "dmtrkovalenko/fff/fff-mcp"
          "oleksandrchekhovskyi/hax/hax"
        ];
        casks = [
          "android-studio-preview@canary"
          "betterdisplay"
          "cleanshot"
          "codex-app"
          "crossover"
          "daisydisk"
          "expo-orbit"
          "iina"
          "linear"
          "steam"
          "zoom"
        ];
        greedyCasks = true;
        caskArgs = {
          appdir = "~/Applications";
          require_sha = false;
        };
        global = {
          autoUpdate = true;
          brewfile = false;
        };
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          cleanup = "zap";
          extraEnv = {
            HOMEBREW_NO_ANALYTICS = "1";
            HOMEBREW_NO_ENV_HINTS = "1";
            HOMEBREW_NO_ASK = "1";
          };
        };
      };

      # Reuse nix-darwin's package set in Home Manager for one consistent
      # nixpkgs configuration and one package evaluation.
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
}
