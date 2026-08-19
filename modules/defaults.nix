# Cross-cutting Den defaults shared by every declared host and user.
{
  den,
  lib,
  ...
}:
{
  den.default = {
    includes = [
      den.batteries.define-user
      den.batteries.hostname
    ];

    # State versions are compatibility markers. Keep them fixed unless the
    # corresponding migration notes have been reviewed.
    darwin.system.stateVersion = 7;
    homeManager.home = {
      stateVersion = "26.11";
      enableNixpkgsReleaseCheck = true;
    };
  };

  # Host users receive an integrated Home Manager configuration by default.
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
