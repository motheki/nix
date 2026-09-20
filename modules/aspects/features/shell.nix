#Yeah. Interactive shell, prompt, completion, and session environment. Zsh is the
# login shell; the other shells remain available for explicit use.
_: {
  den.aspects.features.shell = {
    darwin.programs.zsh = {
      enableGlobalCompInit = false;
      promptInit = "";
    };
    homeManager = {pkgs, ...}: {
      programs = {
        carapace.enable = true;
        skim = {
          enable = true;
          enableZshIntegration = false;
        };
        starship.enable = true;
        vivid = {
          enable = true;
          activeTheme = "rose-pine-moon";
        };
        zoxide.enable = true;

        # Nix/direnv owns activation. Use mise explicitly or through `use mise`
        # in a project's .envrc, without a second runtime-selection prompt hook.
        mise = {
          enable = true;
          enableZshIntegration = false;
          enableBashIntegration = false;
          enableFishIntegration = false;
          enableNushellIntegration = false;
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
          mise.enable = true;
          silent = true;
        };

        bash = {
          enable = true;
          enableVteIntegration = false;
        };
        zsh = {
          enable = true;
          defaultKeymap = "viins";
          enableCompletion = true;
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
          plugins = with pkgs; [
            nushellPlugins.query
            nushellPlugins.polars
            nushellPlugins.gstat
          ];
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
