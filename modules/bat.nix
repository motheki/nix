_: {
  den.aspects.motheki.homeManager = {pkgs, ...}: {
    programs.bat = {
      enable = true;
      config = {
        theme = "ansi";
      };
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
        prettybat
      ];
    };
  };
}
