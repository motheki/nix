{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run  'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
      rebuild-local = "nh home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/personal/nix --show-trace";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean user -q";
      clean-local = "nh clean user -q";
    };
    sessionVariables = {
      ANDROID_HOME="$HOME/Library/Android/sdk";
    };
    sessionPath = [
      "$ANDROID_HOME/emulator"
      "$ANDROID_HOME/platform-tools"
    ];
    packages = with pkgs; [
      #Apps
      iina
      webtorrent_desktop
      slack

      #Dev
      nix-fast-build
      nix-btm
      nix-melt
      nix-tree
      nix-diff
      httpie
      fh
      scc
      rainfrog
      cursor-cli
      hyperfine
			radicle-tui
      comma

      #Utilities
      rm-improved
      dust
      duf
      dua
      lla
      jless
      xcp
      rustscan
      grip-grab
      seanime
      yq-go
      skim
      dogedns
      ffmpeg_8
      imagemagickBig

      # Nur Packages
      nur.repos.AusCyber.zen-browser
      nur.repos.forkprince.helium-nightly
      nur.repos.charmbracelet.wishlist
      nur.repos.charmbracelet.glow
      nur.repos.charmbracelet.vhs

      # Depenencies for Athletiq
      bun
      nodePackages_latest.nodejs
      eas-cli
      cocoapods-beta
      android-studio-tools
      android-tools
      watchman
      fastlane

      # Homebrew Casks
      brewCasks."android-studio-preview@canary"
      brewCasks."expo-orbit"
      brewCasks."raycast"
      brewCasks."betterdisplay"
      brewCasks."cursor"
      brewCasks."legcord"
      brewCasks."discord@canary"
      brewCasks."cleanshot"
      brewCasks."orion"
      brewCasks."linearmouse@beta"
      brewCasks."osaurus"

			#Fonts
			nerd-fonts.commit-mono
			nerd-fonts.monaspace
			nerd-fonts.agave
			nerd-fonts.jetbrains-mono
    ];
  };
  imports = [
    ./modules
  ];
}
