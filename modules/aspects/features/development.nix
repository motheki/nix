# Homebrew owns development runtimes; Home Manager owns their session configuration.
{self, ...}: {
  den.aspects.features.development = {
    darwin.homebrew = {
      brews = [
        "awscli"
        "bun"
        "cocoapods"
        "docker"
        "fastlane"
        "go"
        "gopls"
        "node@24"
        "openjdk@21"
        "pnpm"
        "rust"
        "rust-analyzer"
        "uv"
        "watchman"
        "yarn"
        "zig"
        "zls"
      ];
      casks = ["android-commandlinetools" "android-studio"];
    };
    homeManager = {
      config,
      pkgs,
      ...
    }: let
      homeDirectory = config.home.homeDirectory;
      androidHome = "${homeDirectory}/Library/Android/sdk";
      pnpmHome = "${homeDirectory}/Library/pnpm";
    in {
      home = {
        packages = with pkgs; [
          nixd
          alejandra
          statix
          deadnix
          self.formatter.${pkgs.stdenv.hostPlatform.system}
        ];
        sessionVariables = {
          ANDROID_HOME = androidHome;
          JAVA_HOME = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home";
          PNPM_HOME = pnpmHome;
        };
        sessionPath = [
          "/opt/homebrew/opt/node@24/bin"
          "/opt/homebrew/opt/openjdk@21/bin"
          "/opt/homebrew/bin"
          "/opt/homebrew/sbin"
          "${androidHome}/emulator"
          "${androidHome}/platform-tools"
          "${homeDirectory}/.local/bin"
          "${homeDirectory}/.npm/bin"
          "${pnpmHome}/bin"
          pnpmHome
          "${homeDirectory}/.yarn/bin"
          "${homeDirectory}/.bun/bin"
          "${homeDirectory}/.cargo/bin"
          "${homeDirectory}/go/bin"
        ];
      };
      # Home Manager installs devenv and owns its native auto-activation hooks.
      programs.devenv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
      };
    };
  };
}
