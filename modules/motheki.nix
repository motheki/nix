{ inputs, den, ... }:
{
  den.aspects.motheki = {
    includes = [
      den.provides.define-user
      den.provides.primary-user
      (den.provides.user-shell "zsh")
    ];

    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.nixvim.homeModules.nixvim
          inputs.mac-app-util.homeManagerModules.default
        ];

        home = {
          shellAliases = {
            rebuild-full = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- darwin switch ~/Repos/personal/nix -H mothekis-macbook-pro";
            rebuild = "nh darwin switch -H mothekis-macbook-pro";
            clean-full = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean all -q";
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
          packages = with pkgs; [
            # Apps
            daisydisk
            webtorrent_desktop
            betterdisplay
            iina pi-coding-agent # Dev nix-fast-build nix-init
            nix-melt
            nix-tree
            radicle-tui
            act3
            nix-diff
            httpie
            scc
            rainfrog
            hyperfine
            jless
            comma

            # Utilities
            rm-improved
            nixpkgs-reviewFull
            duf
            utm
            zoom-us
            vulnix
            mos
            dua
            xcp
            rustscan
            grip-grab
            yq-go
            skim
            chafa
            dogedns
            ffmpeg_8
            imagemagickBig
            mdfried
            openapi-tui

            # Dependencies for mobile development
            watchman
            fastlane
            cocoapods-beta

            # Fonts
            nerd-fonts.commit-mono
            nerd-fonts.monaspace
            nerd-fonts.agave
            nerd-fonts.jetbrains-mono
          ];
        };
      };
  };
}
