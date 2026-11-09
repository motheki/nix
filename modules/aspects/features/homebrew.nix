# Homebrew itself and tap sources are lock-pinned; application updates are explicit.
{inputs, ...}: let
  brewVersion = "7.0.10";
in {
  den.aspects.features.homebrew.darwin = {
    config,
    lib,
    ...
  }: let
    cfg = config.nix-homebrew;
    shellEnvironment = prefix:
      lib.optionalString prefix.enable ''
        export HOMEBREW_PREFIX=${lib.escapeShellArg prefix.prefix}
        export HOMEBREW_CELLAR=${lib.escapeShellArg "${prefix.prefix}/Cellar"}
        export HOMEBREW_REPOSITORY=${lib.escapeShellArg "${prefix.library}/.homebrew-is-managed-by-nix"}
      '';
  in {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];
    nix-homebrew = {
      enable = true;
      package =
        inputs.brew-src
        // {
          name = "brew-${brewVersion}";
          version = brewVersion;
        };
      enableZshIntegration = false;
      user = config.system.primaryUser;
      mutableTaps = false;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
    };

    # Equivalent to brew shellenv, without spawning brew for every new shell.
    # CPUTYPE is a zsh builtin; retain the Intel prefix for Rosetta shells.
    programs.zsh.interactiveShellInit = lib.mkIf cfg.enable ''
      case "$CPUTYPE" in
        arm64|aarch64)
          ${shellEnvironment cfg.prefixes.${cfg.defaultArm64Prefix}}
          ;;
        x86_64)
          ${shellEnvironment cfg.prefixes.${cfg.defaultIntelPrefix}}
          ;;
      esac
      typeset -U path fpath
      path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" "''${path[@]}")
      fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" "''${fpath[@]}")
      export PATH FPATH
      # An empty MANPATH component preserves the system's default man directories.
      [[ -z "''${MANPATH-}" ]] || export MANPATH=":''${MANPATH#:}"
      if [[ ":''${INFOPATH-}:" != *":$HOMEBREW_PREFIX/share/info:"* ]]; then
        export INFOPATH="$HOMEBREW_PREFIX/share/info:''${INFOPATH-}"
      fi
    '';

    homebrew = {
      enable = true;
      taps = builtins.attrNames config.nix-homebrew.taps;
      # The static zsh environment above owns initialization.
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
