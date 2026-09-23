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
    homeManager = {host}: {config, ...}: {
      programs.nh.darwinFlake = "${config.home.homeDirectory}/Repos/personal/nix";
      # nh reads NH_DARWIN_FLAKE, so this also works outside the repository.
      home.shellAliases = {
        rebuild = "nh darwin switch --hostname ${host.name}";
        bg = "batgrep";
      };
      programs.yt-dlp.settings.paths = "/Volumes/mothekis_drive/videos/youtube";
    };
  };
}
