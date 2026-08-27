# Machine-specific nix-darwin configuration. Den associates this aspect with
# the host of the same name declared in modules/hosts.nix.
{inputs, ...}: let
  nixHomebrew = inputs.omniflake.lib.load "nix-homebrew" {
    inherit (inputs) brew-src;
  };
in {
  den.aspects.mothekis-macbook-pro.darwin = {config, ...}: {
    imports = [nixHomebrew.darwinModules.nix-homebrew];

    nix = {
      linux-builder = {
        enable = false;
        systems = [
          "aarch64-linux"
          "x86_64-linux"
        ];
      };
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
          "ca-derivations"
          "cgroups"
        ];
        extra-trusted-users = ["motheki"];
        always-allow-substitutes = true;
        extra-substituters = [
          "https://cache.numtide.com"
          "https://nix-community.cachix.org"
          "https://cachix.cachix.org"
          "https://flake-parts.cachix.org"
          "https://nixpkgs.cachix.org"
          "https://nixpkgs-unfree.cachix.org"
        ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
          "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
          "flake-parts.cachix.org-1:IlewuHm3lWYND+tOeQC9nySl7JpzTZ4sqkb1eJMafow="
          "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
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
        "dmtrkovalenko/homebrew-fff" = inputs.fff-mcp;
      };

      # Trust only the third-party formulae that this configuration installs,
      # rather than granting every present and future formula in each tap.
      trust.formulae = [
        "dmtrkovalenko/fff/fff-mcp"
      ];
    };

    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;

      # nix-homebrew emits shellenv once for both native and Rosetta prefixes.
      enableZshIntegration = false;
      brews = [
        "cocoapods"
        "dmtrkovalenko/fff/fff-mcp"
      ];
      casks = [
        "android-studio-preview@canary"
        "daisydisk"
        "chatgpt"
        "steam"
        "thebrowsercompany-dia"
        "raycast"
        "betterdisplay"
        "cleanshot"
        "linear"
        "obs"
        "mos"
        "zen-browser"
      ];
      greedyCasks = true;
      caskArgs = {
        appdir = "/Applications";
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
