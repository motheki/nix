{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
      prettybat
    ];
  };
}
