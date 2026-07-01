{
  inputs,
  den,
  ...
}: {
  den.aspects.motheki = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "zsh")
      den.aspects.profiles.apps
      den.aspects.profiles.cli
      den.aspects.profiles.nixvim
      den.aspects.profiles.vcs
    ];

    homeManager = {pkgs, ...}: let
      appPackages = with pkgs; [
        daisydisk
        webtorrent_desktop
      ];
      utilityPackages = with pkgs; [
        rm-improved
        hyperfine
        rainfrog
        jless
        comma
        bottom
        nix-melt
        jj-starship
        herdr
        nix-tree
        radicle-tui
        duckdb
        act3
        nix-diff
        gftp
        httpie
        scc
        nixpkgs-reviewFull
        duf
        mosh
        inetutils
        vulnix
        dua
        xcp
        orbstack
        rustscan
        lazyjj
        grip-grab
        sd
        yq-go
        skim
        #watchman
        pnpm
        chafa
        aube
        dogedns
        ffmpeg_8
        imagemagickBig
        mdfried
        openapi-tui
      ];
      mobilePackages = with pkgs; [
        fastlane
        pdf-cli
      ];
      fontPackages = with pkgs; [
        nerd-fonts.commit-mono
        nerd-fonts.monaspace
        nerd-fonts.agave
        nerd-fonts.jetbrains-mono
      ];
    in {
      imports = [
        inputs.nixvim.homeModules.nixvim
        inputs.mac-app-util.homeManagerModules.default
      ];

      targets.darwin.mac-app-util.enable = false;

      home = {
        shellAliases = {
          rebuild-full = "nix --extra-experimental-features 'nix-command flakes' run ~/Repos/personal/nix#darwin-switch -- -H mothekis-macbook-pro";
          rebuild = "nh darwin switch -H mothekis-macbook-pro";
          clean-full = "nix --extra-experimental-features 'nix-command flakes' run ~/Repos/personal/nix#clean";
          clean = "nh clean all -q";
        };
        sessionVariables = {
          ANDROID_HOME = "$HOME/Library/Android/sdk";
        };
        sessionPath = [
          "$ANDROID_HOME/emulator"
          "$ANDROID_HOME/platform-tools"
          "/Users/motheki/.bun/bin"
          "/Users/motheki/.cargo/bin"
        ];
        packages = appPackages ++ utilityPackages ++ mobilePackages ++ fontPackages;
      };
    };
  };
}
