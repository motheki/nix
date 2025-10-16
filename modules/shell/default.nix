{...}: {
  programs = {
    fd = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv = {enable = true;};
      silent = true;
    };
    ripgrep = {
      enable = true;
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
