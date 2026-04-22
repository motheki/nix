{ pkgs, ... }:
{
  services = {
    pueue = {
      enable = true;
    };
    colima = {
      enable = true;
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
      settings = {
        "org.gradle.caching" = true;
        "org.gradle.parallel" = true;
        "org.gradle.home" = pkgs.jdk25;
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
      enable = true;
    };
    uv = {
      enable = true;
    };
    lazydocker = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
      silent = true;
    };
    tirith = {
      enable = true;
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
}
