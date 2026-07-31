{lib, ...}: {
  den.schema.user.classes = lib.mkDefault ["homeManager"];
  den.default.homeManager.home.stateVersion = "26.11";
  den.default.homeManager.home.enableNixpkgsReleaseCheck = true;
}
