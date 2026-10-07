# Homebrew itself and tap sources are lock-pinned; application updates are explicit.
{inputs, ...}: {
  flake-file.inputs = {
    brew-src = {
      url = "github:Homebrew/brew";
      flake = false;
    };
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.brew-src.follows = "brew-src";
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
  };

  den.aspects.features.homebrew.darwin = {config, ...}: {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];
    nix-homebrew = {
      enable = true;
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
        # nix-homebrew installs immutable taps. `nix flake update` advances them;
        # activation installs/upgrades from those sources without `brew update`.
        autoUpdate = false;
        upgrade = true;
        # Remove undeclared packages while preserving application data.
        cleanup = "uninstall";
        extraEnv = {
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_ASK = "1";
        };
      };
    };
  };
}
