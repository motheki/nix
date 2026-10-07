# Host-qualified aspects compose with the shared motheki identity in Den.
# Workload selection and machine-local paths belong here, not in reusable tools.
{den, ...}: {
  den.aspects."motheki@mothekis-macbook-pro" = {
    includes = [
      den.batteries.primary-user
      den.aspects.profiles.workstation
      den.aspects.profiles.editor-full
      den.aspects.profiles.mobile-developer
    ];
    homeManager = {host}: {
      config,
      lib,
      ...
    }: {
      programs.nh.darwinFlake = "${config.home.homeDirectory}/Repos/personal/nix";
      # Use the same pinned NH as the host and development shell. Updating is
      # explicit so a normal rebuild reproduces the reviewed lock file.
      home.shellAliases = {
        rebuild = "nh darwin switch --hostname ${host.name} ${lib.escapeShellArg config.programs.nh.darwinFlake}";
        rebuild-update = "nh darwin switch --update --hostname ${host.name} ${lib.escapeShellArg config.programs.nh.darwinFlake}";
        bg = "batgrep";
      };
      programs.yt-dlp.settings.paths = "/Volumes/mothekis_drive/videos/youtube";
    };
  };
}
