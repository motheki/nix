{pkgs, ...}: {
  programs.fd = {
    enable = true;
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
