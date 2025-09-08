{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "rose-pine-dawn";
      font-size = 10;
    };
  };
}
