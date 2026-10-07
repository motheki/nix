# One capability spans native application ownership and the user's environment.
{inputs, ...}: {
  flake-file.inputs.maestro-tap = {
    url = "github:mobile-dev-inc/homebrew-tap";
    flake = false;
  };

  den.aspects.features.mobile-development = {
    darwin = {
      nix-homebrew.taps."mobile-dev-inc/homebrew-tap" = inputs.maestro-tap;
      homebrew = {
        brews = [
          "cocoapods"
          {
            name = "mobile-dev-inc/tap/maestro";
            trusted = true;
          }
        ];
        casks = ["android-studio-preview@canary"];
      };
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
