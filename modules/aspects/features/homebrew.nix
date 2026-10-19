# Homebrew itself and tap sources are lock-pinned; application updates are explicit.
{inputs, ...}: let
  brewVersion = "7.0.10";
in {
  flake-file.inputs = {
    brew-src = {
      url = "github:Homebrew/brew/${brewVersion}";
      flake = false;
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew/main";
      inputs.brew-src.follows = "brew-src";
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core/main";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask/main";
      flake = false;
    };
  };

  den.aspects.features.homebrew.darwin = {config, ...}: {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];
    nix-homebrew = {
      enable = true;
      package =
        inputs.brew-src
        // {
          name = "brew-${brewVersion}";
          version = brewVersion;
        };
      enableZshIntegration = true;
      user = config.system.primaryUser;
      mutableTaps = false;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
    };

    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
      # nix-homebrew emits shellenv; do not initialize it twice.
      enableZshIntegration = false;
      greedyCasks = true;
      caskArgs = {
        appdir = "/Applications";
      };
      global = {
        autoUpdate = false;
        brewfile = false;
      };
      onActivation = {
        autoUpdate = false;
        upgrade = true;
        cleanup = "uninstall";
        extraEnv = {
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_ASK = "1";
        };
      };
    };
  };
}
