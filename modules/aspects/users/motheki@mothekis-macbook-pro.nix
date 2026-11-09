# Host-qualified aspects compose with the shared motheki identity in Den.
# Workload selection and machine-local paths belong here, not in reusable tools.
{den, ...}: {
  den.aspects."motheki@mothekis-macbook-pro" = {
    includes = [
      den.batteries.primary-user
      den.aspects.profiles.workstation
      den.aspects.profiles.editor-full
    ];
    homeManager = {host}: {
      config,
      lib,
      pkgs,
      ...
    }: {
      programs.nh.darwinFlake = "${config.home.homeDirectory}/Repos/personal/nix";
      home.packages = [
        (pkgs.writeShellApplication {
          name = "rebuild";
          runtimeInputs = [pkgs.nix config.programs.nh.package];
          text = ''
            cd ${lib.escapeShellArg config.programs.nh.darwinFlake}
            nix flake update
            nh darwin switch . -H ${lib.escapeShellArg host.name} --ask
          '';
        })
      ];
      home.shellAliases.bg = "batgrep";
      programs.yt-dlp.settings.paths = "/Volumes/mothekis_drive/videos/youtube";
    };
  };
}
