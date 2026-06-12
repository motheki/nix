_: {
  den.aspects.motheki.homeManager = {pkgs, ...}: let
    javaPackage = pkgs.jdk17;
  in {
    services = {
      pueue.enable = true;
      colima.enable = false;
    };

    programs = {
      aria2.enable = true;
      awscli.enable = true;
      bun.enable = true;
      cargo.enable = true;
      carapace.enable = true;
      docker-cli.enable = false;
      fastfetch.enable = true;
      fd.enable = true;
      jq.enable = true;
      lazydocker.enable = false;
      pay-respects.enable = true;
      ripgrep.enable = true;
      ripgrep-all.enable = true;
      television.enable = true;
      tiny.enable = true;
      uv.enable = true;
      zoxide.enable = true;

      bat = {
        enable = true;
        config.theme = "ansi";
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          batgrep
          batwatch
          prettybat
        ];
      };

      gradle = {
        enable = true;
        package = pkgs.gradle_9-unwrapped;
        settings = {
          "org.gradle.caching" = true;
          "org.gradle.parallel" = true;
          "org.gradle.home" = javaPackage;
        };
      };

      eza = {
        enable = true;
        extraOptions = [
          "--icons"
          "-a"
          "-l"
        ];
      };

      man = {
        enable = true;
        package = pkgs.man;
      };

      java = {
        enable = true;
        package = javaPackage;
      };

      npm = {
        enable = true;
        package = pkgs.nodejs_latest;
      };

      vscode.enable = false;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };

      tirith.enable = false;

      vivid = {
        enable = true;
        activeTheme = "rose-pine-dawn";
      };

      starship = {
        enable = true;
        enableTransience = true;
      };

      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
      };

      bash = {
        enable = true;
        enableVteIntegration = true;
      };

      zsh = {
        enable = true;
        defaultKeymap = "viins";
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };

      fish = {
        enable = true;
        generateCompletions = false;
        interactiveShellInit = "set -U fish_greeting";
      };

      nix-index.enable = true;

      nix-your-shell = {
        enable = true;
        nix-output-monitor.enable = true;
      };

      nix-search-tv = {
        enable = true;
        enableTelevisionIntegration = true;
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
    };
  };
}
