{
  inputs,
  den,
  ...
}: {
  den.aspects."mothekis-macbook-pro" = {
    includes = [den.provides.hostname];

    darwin = {
      config,
      pkgs,
      ...
    }: {
      imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

      nix = {
        package = pkgs.nixVersions.latest;
        nixPath = ["nixpkgs=flake:nixpkgs"];
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];

          extra-trusted-users = ["motheki"];
          always-allow-substitutes = true;
        };
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.nur.overlays.default
          (_final: prev: {
            opencode = prev.opencode.overrideAttrs (old: {
              postPatch =
                (old.postPatch or "")
                + ''
                  substituteInPlace packages/opencode/script/build.ts \
                    --replace-fail 'console.log(`Running smoke test: ''${binaryPath} --version`)' \
                                   'if (process.platform === "darwin") await $`/usr/bin/codesign --force --sign - ''${binaryPath}`; console.log(`Running smoke test: ''${binaryPath} --version`)'
                '';
              postFixup =
                (old.postFixup or "")
                + ''
                  for binary in "$out/bin/opencode" "$out/bin/.opencode-wrapped"; do
                    if [ -e "$binary" ]; then
                      /usr/bin/codesign --force --sign - "$binary"
                    fi
                  done
                '';
            });
          })
        ];
      };

      system.stateVersion = 6;

      environment = {
        systemPackages = [pkgs.nh];
        variables.NH_DARWIN_FLAKE = "/Users/motheki/Repos/personal/nix";
      };

      security.pam.services.sudo_local.touchIdAuth = true;

      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "motheki";
        autoMigrate = false;
        mutableTaps = false;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
        };
      };

      homebrew = {
        enable = true;
        taps = builtins.attrNames config.nix-homebrew.taps;
        enableZshIntegration = true;
        brews = [
          "pi-coding-agent"
        ];
        greedyCasks = true;
        global = {
          autoUpdate = true;
          brewfile = false;
        };
        caskArgs = {
          appdir = "~/Applications";
          require_sha = false;
        };
        casks = [
          "android-studio-preview@canary"
          "adguard-vpn@nightly"
          "codex-app"
          "thebrowsercompany-dia"
          "legcord"
          "zoom"
          "iina"
          "codex"
          "obs"
        ];
        onActivation = {
          autoUpdate = true;
          upgrade = true;
          extraEnv = {
            HOMEBREW_NO_ANALYTICS = "1";
            HOMEBREW_NO_ENV_HINTS = "1";
            HOMEBREW_DEVELOPER = "1";
            HOMEBREW_NO_ASK = "1";
            # Remove once Homebrew recognizes macOS 27.
            HOMEBREW_FAKE_MACOS = "26";
          };
        };
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
  };

  den.aspects.motheki.homeManager = {
    programs.nh = {
      enable = true;
      flake = "/Users/motheki/Repos/personal/nix";
      darwinFlake = "/Users/motheki/Repos/personal/nix";
      clean = {
        enable = true;
        extraArgs = "--optimise  --max";
      };
    };
  };
}
