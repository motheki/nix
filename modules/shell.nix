{ den, ... }:
{
  den.aspects.motheki.homeManager =
    { pkgs, ... }:
    {
      services = {
        pueue = {
          enable = true;
        };
        colima = {
          enable = false;
        };
      };
      programs = {
        aria2 = {
          enable = true;
        };
        fd = {
          enable = true;
        };
        gradle = {
          enable = true;
          package = pkgs.gradle_9-unwrapped;
          settings = {
            "org.gradle.caching" = true;
            "org.gradle.parallel" = true;
            "org.gradle.home" = pkgs.jdk17;
          };
        };
        eza = {
          enable = true;
        };
        man = {
          enable = true;
          package = pkgs.man;
        };
        docker-cli = {
          enable = false;
        };
        uv = {
          enable = true;
        };
        lazydocker = {
          enable = false;
        };
        direnv = {
          enable = true;
          nix-direnv = {
            enable = true;
          };
          silent = true;
        };
        tirith = {
          enable = false;
        };
        ripgrep = {
          enable = true;
        };
        ripgrep-all = {
          enable = true;
        };
        vivid = {
          enable = true;
          activeTheme = "nord";
        };
        pay-respects = {
          enable = true;
        };
        zoxide = {
          enable = true;
        };
        starship = {
          enable = true;
          enableTransience = true;
        };
        jq = {
          enable = true;
        };
        fastfetch = {
          enable = true;
        };
        tealdeer = {
          enable = true;
          settings = {
            updates = {
              auto_update = true;
            };
          };
        };
        bash = {
          enable = true;
          enableVteIntegration = true;
        };
        zsh = {
          enable = true;
          defaultKeymap = "viins";
          enableCompletion = true;
          autosuggestion = {
            enable = true;
          };
          syntaxHighlighting = {
            enable = true;
          };
        };
        carapace = {
          enable = true;
        };
        fish = {
          enable = true;
          generateCompletions = false;
          interactiveShellInit = "set -U fish_greeting";
        };
        nix-index = {
          enable = true;
        };
        nix-your-shell = {
          enable = true;
          nix-output-monitor = {
            enable = true;
          };
        };
      };
    };
}
