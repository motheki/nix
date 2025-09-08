{pkgs, ...}: {
  services.ollama = {
    enable = true;
  };
  programs.mods = {
    enable = true;
  };
  programs.fd = {
    enable = true;
  };
  programs.television = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      prettybat
      batwatch
      batgrep
      batdiff
    ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv = {enable = true;};
    silent = true;
  };
  programs.ripgrep = {
    enable = true;
  };
  programs.zoxide = {enable = true;};
  programs.starship = {
    enable = true;
  };
  programs.jq = {enable = true;};
  programs.tealdeer = {
    enable = true;
    settings = {updates = {auto_update = true;};};
  };
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "viins";
    syntaxHighlighting = {
      enable = true;
    };
  };
}
