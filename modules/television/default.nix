{pkgs, ...}: {
  programs.television = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.nix-search-tv = {
    enable = true;
    enableTelevisionInegration = true;
  };
}
