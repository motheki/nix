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
      # Bootstrap current NH independently of the installed generation. Its native
      # --update refreshes flake.lock before building Darwin and integrated HM.
      # Pass the path explicitly so bootstrap also works without new session vars.
      home.shellAliases = {
        rebuild = "nix run --refresh github:nix-community/nh -- darwin switch --update --hostname ${host.name} ${lib.escapeShellArg config.programs.nh.darwinFlake}";
        bg = "batgrep";
      };
      programs.yt-dlp.settings.paths = "/Volumes/mothekis_drive/videos/youtube";
    };
  };
}
