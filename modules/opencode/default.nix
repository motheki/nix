{pkgs, ...}: {
  programs.opencode = {
    package = pkgs.opencode;
    enable = true;
  };
}
