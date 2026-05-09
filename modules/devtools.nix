{ den, ... }:
{
  den.aspects.motheki.homeManager =
    { pkgs, ... }:
    {
      programs.bun = {
        enable = true;
      };
      programs.cargo = {
        enable = true;
      };
      programs.java = {
        package = pkgs.jdk25;
        enable = true;
      };
      programs.npm = {
        package = pkgs.nodejs_latest;
        enable = true;
      };
    };
}
