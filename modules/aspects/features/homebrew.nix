# Homebrew itself and tap sources are pinned; application updates are explicit.
{inputs, ...}: let
  nixHomebrew = (import ../../_lib/optional-inputs.nix inputs).nix-homebrew;
in {
  flake-file.inputs = {
    brew-src = {
      url = "github:Homebrew/brew";
      flake = false;
    };
    homebrew-core = {
      url = "github:Homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:Homebrew/homebrew-cask";
      flake = false;
    };
    fff-mcp = {
      url = "github:dmtrKovalenko/homebrew-fff";
      flake = false;
    };
  };

  den.aspects.features.homebrew.darwin = {config, ...}: {
    imports = [nixHomebrew.darwinModules.nix-homebrew];
    nix-homebrew = {
      enable = true;
      enableZshIntegration = true;
      user = config.system.primaryUser;
      mutableTaps = false;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
        "dmtrkovalenko/homebrew-fff" = inputs.fff-mcp;
      };
      trust.formulae = ["dmtrkovalenko/fff/fff-mcp"];
    };

    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
      # nix-homebrew emits shellenv; do not initialize it twice.
      enableZshIntegration = false;
      greedyCasks = false;
      caskArgs = {
        appdir = "/Applications";
        require_sha = false;
      };
      global = {
        autoUpdate = false;
        brewfile = false;
      };
      onActivation = {
        autoUpdate = false;
        upgrade = false;
        cleanup = "none";
        extraEnv = {
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_ENV_HINTS = "1";
          HOMEBREW_NO_ASK = "1";
        };
      };
    };
  };
}
