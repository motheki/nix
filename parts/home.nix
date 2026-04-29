{inputs, ...}: {
  flake = {
    homeConfigurations = {
      motheki = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
          overlays = [
            inputs.brew-nix.overlays.default
            inputs.nur.overlays.default
          ];
        };
        modules = [
          inputs.nixvim.homeModules.nixvim
          (inputs.import-tree ../modules)
          (
            { pkgs, ... }:
            {
              home = {
                homeDirectory = "/Users/motheki";
                username = "motheki";
                stateVersion = "26.05";
                shellAliases = {
                  rebuild-full = "nix --extra-experimental-features 'nix-command flakes' run  'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
                  rebuild = "nh home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
                  manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/personal/nix --show-trace";
                  clean-full = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean all -q";
                  clean = "nh clean all -q";
                };
                sessionVariables = {
                  ANDROID_HOME = "$HOME/Library/Android/sdk";
                  CLAUDE_CODE_NO_FLICKER = 1;
                  CLAUDE_CODE_DISABLE_MOUSE = 1;
                };
                sessionPath = [
                  "$ANDROID_HOME/emulator"
                  "$ANDROID_HOME/platform-tools"
                  "/Users/motheki/.bun/bin"
                ];
                packages = with pkgs; [

                  #Apps

                  iina
                  raycast
                  daisydisk
                  webtorrent_desktop
                  betterdisplay
                  brewCasks."cleanshot"
                  mos

                  #Dev

                  nix-fast-build
                  nix-init
                  nix-melt
                  nix-tree
                  radicle-tui
                  act3
                  nix-diff
                  httpie
                  scc
                  claude-monitor
                  rainfrog
                  hyperfine
                  jless
                  comma

                  #Utilities

                  rm-improved
                  nixpkgs-reviewFull
                  duf
                  utm
                  zoom-us
                  vulnix
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
                  youtube-tui

                  # Nur Packages

                  nur.repos.charmbracelet.wishlist
                  nur.repos.charmbracelet.glow
                  nur.repos.charmbracelet.vhs

                  # Depenencies for Mobile Development

                  brewCasks."android-studio"
                  cocoapods-beta
                  gradle_9-unwrapped
                  folly
                  pkg-config-unwrapped
                  watchman
                  fastlane

                  #Fonts

                  nerd-fonts.commit-mono
                  nerd-fonts.monaspace
                  nerd-fonts.agave
                  nerd-fonts.jetbrains-mono
                ];
              };
            }
          )
        ];
      };
    };
  };
}
