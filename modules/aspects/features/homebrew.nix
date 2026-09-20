# Homebrew itself and tap sources are lock-pinned; application updates are explicit.
{inputs, ...}: {
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
          HOMEBREW_NO_ASK = "1";
        };
      };
    };
  };
}
