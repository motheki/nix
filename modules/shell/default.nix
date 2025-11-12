{...}: {
  services = {
    pueue = {
      enable = true;
    };
  };
  programs = {
    fd = {
      enable = true;
    };
    #direnv = {
    #  enable = true;
    #  nix-direnv = {enable = true;};
    #  enableFishIntegration = false;
    #  silent = true;
    #};
    ripgrep = {
      enable = true;
    };
    vivid = {
      enable = true;
      activeTheme = "rose-pine-dawn";
    };
    zoxide = {enable = true;};
    starship = {
      enable = true;
    };
    jq = {enable = true;};
    tealdeer = {
      enable = true;
      settings = {updates = {auto_update = true;};};
    };
    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
      };
      defaultKeymap = "viins";
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
