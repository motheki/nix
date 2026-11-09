# Interactive shell, prompt, completion, and session environment. Zsh is the
# login shell; the other shells remain available for explicit use.
_: {
  den.aspects.features.shell = {
    darwin.programs.zsh = {
      enableGlobalCompInit = false;
      promptInit = "";
    };
    homeManager = _: {
      programs = {
        carapace.enable = true;
        starship.enable = true;
        vivid = {
          enable = true;
          activeTheme = "rose-pine-dawn";
        };
        zoxide.enable = true;

        # Direnv owns project activation. Keep mise available for explicit use
        # without a second runtime-selection prompt hook.
        mise = {
          enable = true;
          enableZshIntegration = false;
          enableBashIntegration = false;
          enableFishIntegration = false;
          enableNushellIntegration = false;
        };

        bash = {
          enable = true;
          enableVteIntegration = false;
        };
        zsh = {
          enable = true;
          defaultKeymap = "viins";
          enableCompletion = true;
          # Apple and Nix zsh must not invalidate each other's completion dump.
          # Keep compinit's normal permission checks and cache invalidation.
          completionInit = ''
            autoload -Uz compinit && compinit -d "''${ZDOTDIR:-$HOME}/.zcompdump-$ZSH_VERSION"
          '';
          autocd = true;
          autosuggestion.enable = true;
          fastSyntaxHighlighting.enable = true;
          history = {
            ignoreAllDups = true;
            expireDuplicatesFirst = true;
            saveNoDups = true;
            findNoDups = true;
          };
        };
        fish = {
          enable = true;
          generateCompletions = true;
          interactiveShellInit = "set -g fish_greeting";
        };
        nushell = {
          enable = true;
          #plugins = with pkgs; [
          #  nushellPlugins.query
          #  nushellPlugins.skim
          #  nushellPlugins.polars
          #  nushellPlugins.gstat
          #];
          settings = {
            show_banner = false;
            edit_mode = "vi";
          };
        };

        nix-your-shell = {
          enable = true;
          nix-output-monitor.enable = true;
        };
        nix-search-tv = {
          enable = true;
          enableTelevisionIntegration = true;
        };
      };
    };
  };
}
