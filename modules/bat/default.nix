{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "rose-pine-dawn";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      prettybat
      batwatch
      #batgrep
      batdiff
    ];
  };
}
