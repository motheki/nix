{pkgs, ...}: {
  programs.bun = {
    enable = true;
  };
  programs.java = {
    package = pkgs.jdk17;
    enable = true;
  };
  programs.npm = {
    package = pkgs.nodejs_latest;
    enable = true;
  };
}
