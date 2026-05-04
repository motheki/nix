{ den, ... }:
{
  den.aspects.motheki.homeManager = {
    programs.nh = {
      enable = true;
      flake = "/Users/motheki/Repos/personal/nix";
      darwinFlake = "/Users/motheki/Repos/personal/nix";
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
    };
  };
}
