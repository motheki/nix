{ pkgs, ... }:
{
  services = {
    pueue = {
      enable = true;
    };
  };
  programs = {
    fd = {
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
    vivid = {
      enable = true;
      activeTheme = "rose-pine-dawn";
    };
    pay-respects = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
    nix-index = {
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
    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
        strategy = [ "completion" ];
      };
      autocd = true;
      defaultKeymap = "viins";
      syntaxHighlighting = {
        enable = true;
      };
    };
    carapace = {
      enable = true;
    };
    fish = {
      enable = true;
      generateCompletions = true;
      interactiveShellInit = "set -U fish_greeting";
    };
    nix-your-shell = {
      enable = true;
      nix-output-monitor = {
        enable = true;
      };
    };
  };
}
