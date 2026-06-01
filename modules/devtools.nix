_: {
  den.aspects.motheki.homeManager = {pkgs, ...}: {
    programs.bun = {
      enable = true;
    };
    programs.cargo = {
      enable = true;
    };
    programs.vscode = {
      enable = false;
    };
    programs.java = {
      package = pkgs.jdk17;
      enable = true;
    };
    programs.npm = {
      package = pkgs.nodejs_latest;
      enable = true;
    };
  };
}
