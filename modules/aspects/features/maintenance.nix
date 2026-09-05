# One owner per job: user profile pruning, system pruning/GC, store optimisation.
let
  policy = import ../../_lib/maintenance.nix;
in {
  den.aspects.features.maintenance = {
    darwin = {
      pkgs,
      lib,
      ...
    }: {
      nix.gc.automatic = false;
      nix.optimise = {
        automatic = true;
        interval = [
          {
            Weekday = 3;
            Hour = 4;
            Minute = 15;
          }
        ];
      };
      launchd.daemons.nix-profile-cleanup.serviceConfig = {
        ProgramArguments =
          [
            (lib.getExe pkgs.nh)
            "clean"
            "profile"
            policy.systemProfile
          ]
          ++ policy.retentionArgs ++ policy.preserveRootsArgs;
        StartCalendarInterval = [
          {
            Weekday = 1;
            Hour = 3;
            Minute = 15;
          }
        ];
        ProcessType = "Background";
        LowPriorityIO = true;
        StandardOutPath = "/var/log/nix-profile-cleanup.log";
        StandardErrorPath = "/var/log/nix-profile-cleanup.log";
      };
    };
    homeManager = {
      config,
      pkgs,
      lib,
      ...
    }: {
      # The pinned HM nh module combines extraArgs into one launchd argument.
      # Use explicit argv instead; only the system daemon runs store GC.
      programs.nh.clean.enable = false;
      launchd.agents.nix-user-cleanup = {
        enable = true;
        config = {
          ProgramArguments =
            [
              (lib.getExe pkgs.nh)
              "clean"
              "user"
              "--no-gc"
            ]
            ++ policy.retentionArgs ++ policy.preserveRootsArgs;
          StartCalendarInterval = [
            {
              Weekday = 0;
              Hour = 22;
              Minute = 15;
            }
          ];
          ProcessType = "Background";
          LowPriorityIO = true;
          StandardOutPath = "${config.home.homeDirectory}/Library/Logs/nix-user-cleanup.log";
          StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/nix-user-cleanup.log";
        };
      };
    };
  };
}
