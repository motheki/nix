# Interactive shell, prompt, completion, and session environment. Zsh is the
# login shell; the other shells remain available for explicit use.
_: {
  den.aspects.profiles.shell.homeManager = {
    config,
    pkgs,
    ...
  }: let
    homeDirectory = config.home.homeDirectory;
    androidHome = "${homeDirectory}/Library/Android/sdk";
  in {
    home = {
      shellAliases = {
        rebuild = "nh darwin switch -H mothekis-macbook-pro";
        clean = "nh clean all -q";
      };
      sessionVariables.ANDROID_HOME = androidHome;
      sessionPath = [
        "${androidHome}/emulator"
        "${androidHome}/platform-tools"
        "${homeDirectory}/.bun/bin"
        "${homeDirectory}/.cargo/bin"
      ];
    };

    programs = {
      carapace.enable = true;
      skim = {
        enable = true;
        enableZshIntegration = false;
      };
      starship.enable = true;
      vivid = {
        enable = true;
        activeTheme = "rose-pine-dawn";
      };
      zoxide.enable = true;

      mise.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        mise.enable = true;
        silent = true;
      };

      bash = {
        enable = true;
        enableVteIntegration = true;
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
}
