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
        "dmtrkovalenko/homebrew-fff" = inputs.fff-mcp;
      };
      trust.formulae = ["dmtrkovalenko/fff/fff-mcp"];
    };

    homebrew = {
      enable = true;
      brews = ["dmtrkovalenko/fff/fff-mcp"];
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
