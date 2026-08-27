# General-purpose terminal programs. Development toolchains and interactive
# shell behavior are kept in their own profiles.
_: {
  den.aspects.profiles.command-line.homeManager = {
    config,
    pkgs,
    ...
  }: {
    fonts.fontconfig.enable = true;
    services.pueue.enable = true;

    programs = {
      aria2.enable = true;
      fastfetch.enable = true;
      fd.enable = true;
      jq.enable = true;
      lazydocker.enable = true;
      nix-index.enable = true;
      pay-respects.enable = true;
      ripgrep.enable = true;
      ripgrep-all.enable = true;
      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
      };
      television.enable = true;
      tiny.enable = true;

      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/Repos/personal/nix";
        clean = {
          enable = true;
          extraArgs = "--optimise --max";
        };
      };

      bat = {
        enable = true;
        config.theme = "ansi";
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          batgrep
          batwatch
          prettybat
        ];
      };

      eza = {
        enable = true;
        extraOptions = [
          "--icons"
          "--all"
          "--long"
        ];
      };

      man = {
        enable = true;
        package = pkgs.man;
      };
    };
  };
}
