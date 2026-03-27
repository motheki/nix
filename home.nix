{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "26.05";
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run  'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
      rebuild-local = "nh home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/personal/nix --show-trace";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean user -q";
      clean-local = "nh clean user -q";
    };
    sessionVariables = {
      ANDROID_HOME = "$HOME/Library/Android/sdk";
    };
    sessionPath = [
      "$ANDROID_HOME/emulator"
      "$ANDROID_HOME/platform-tools"
      "/Users/motheki/.bun/bin"
    ];
    packages = with pkgs; [
      #Apps
      iina
      #webtorrent_desktop

      #Dev
      nix-fast-build
      nix-btm
      nix-init
      nix-melt
      nix-tree
      nix-diff
      httpie
      fh
      scc
      claude-monitor
      rainfrog
      hyperfine
      comma

      #Utilities
      rm-improved
      dust
      nixpkgs-reviewFull
      duf
      utm
      zoom-us
      vulnix
      dua
      lla
      jless
      xcp
      rustscan
      grip-grab
      yq-go
      skim
      chafa
      dogedns
      ffmpeg_8
      imagemagickBig

      # Nur Packages
      nur.repos.charmbracelet.wishlist
      nur.repos.charmbracelet.glow
      nur.repos.charmbracelet.vhs

      # Depenencies for AthletIQ
      cocoapods-beta
      gradle_9-unwrapped
      android-studio-tools
      android-tools
      watchman
      fastlane

      # Homebrew Casks
      brewCasks."android-studio-preview@canary"
      brewCasks."expo-orbit"
      brewCasks."cleanshot"
      brewCasks."raycast"
      brewCasks."betterdisplay"
      brewCasks."linearmouse@beta"
      brewCasks."obs@beta"

      #Fonts
      nerd-fonts.commit-mono
      nerd-fonts.monaspace
      nerd-fonts.agave
      nerd-fonts.jetbrains-mono
    ];
  };
}
