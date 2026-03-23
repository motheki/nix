{pkgs, ...}: {
  programs.discord = {
    enable = false;
    package = pkgs.discord-canary;
  };
}
