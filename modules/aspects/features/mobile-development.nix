# One capability spans native application ownership and the user's environment.
{
  den.aspects.features.mobile-development = {
    darwin.homebrew = {
      brews = [];
      casks = ["android-studio-preview@canary"];
    };
    homeManager = {
      config,
      pkgs,
      ...
    }: let
      androidHome = "${config.home.homeDirectory}/Library/Android/sdk";
    in {
      home = {
        packages = [pkgs.fastlane];
        sessionVariables.ANDROID_HOME = androidHome;
        sessionPath = ["${androidHome}/emulator" "${androidHome}/platform-tools"];
      };
      # Java and Gradle are project-scoped: `nix develop .#mobile`.
      # Existing SDKs, simulators, and Xcode remain managed by their vendor tools.
    };
  };
}
