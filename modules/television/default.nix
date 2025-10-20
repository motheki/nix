{...}: {
  programs.television = {
    enable = true;
    enableZshIntegration = true;
    settings = {
    };
  };
  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
  };
}
