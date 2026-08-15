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
      den.aspects.profiles.llm-agents
      den.aspects.profiles.cli
      den.aspects.profiles.nixvim
      den.aspects.profiles.vcs
    ];

    homeManager = {pkgs, ...}: let
      appPackages = with pkgs; [
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
        mos
        orbstack
        rustscan
        grip-grab
        sd
        yq-go
        chafa
        tuicr
        dogedns
        ffmpeg_9-full
        imagemagickBig
        mdfried
        glow
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
      imports = [inputs.nixvim.homeModules.nixvim];

      home = {
        shellAliases = {
          rebuild = "nh darwin switch -H mothekis-macbook-pro";
          clean = "nh clean all -q";
        };
        sessionVariables = {
          ANDROID_HOME = "$HOME/Library/Android/sdk";
        };
        sessionPath = [
          "$ANDROID_HOME/emulator"
          "$ANDROID_HOME/platform-tools"
          "$HOME/.bun/bin"
          "$HOME/.cargo/bin"
        ];
        packages = appPackages ++ utilityPackages ++ mobilePackages ++ fontPackages;
      };
    };
  };
}
