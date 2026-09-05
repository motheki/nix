# Everyday tools. Project shells own language versions; no mutable PATH prefixes.
{
  den.aspects.features.development.homeManager = {pkgs, ...}: {
    home.packages = [pkgs.nodejs];
    programs = {
      awscli.enable = true;
      bun.enable = true;
      devenv.enable = true;
      docker-cli.enable = true;
      npm.enable = true;
      uv.enable = true;
      yarn.enable = true;
    };
  };
}
