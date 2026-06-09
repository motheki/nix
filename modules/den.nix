{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.den.flakeModule];

  den.schema.user.classes = lib.mkDefault ["homeManager"];
  den.default.homeManager.home.stateVersion = "26.05";
  den.default.homeManager.home.enableNixpkgsReleaseCheck = true;
}
