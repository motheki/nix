# Cross-cutting Den defaults shared by every declared host and user.
{
  den,
  lib,
  ...
}: {
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ];

    # State versions are compatibility markers. Keep them fixed unless the
    # corresponding migration notes have been reviewed.
    darwin = {
      system.stateVersion = 7;

      # Home Manager reuses each Darwin host's package set, so this allows
      # unfree packages consistently for both system and user packages.
      nixpkgs.config.allowUnfree = true;

      # Native HM collision handling, not a custom mutable-profile merger.
      # An existing backup stops activation instead of being overwritten.
      home-manager = {
        backupFileExtension = "before-declarative";
        overwriteBackup = false;
      };
    };
    homeManager.home = {
      stateVersion = "26.11";
      enableNixpkgsReleaseCheck = true;
    };
  };

  # Host users receive an integrated Home Manager configuration by default.
  den.schema.user.classes = lib.mkDefault ["homeManager"];
}
