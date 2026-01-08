{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
      rebuild-local = "nh home switch -u -q --impure --accept-flake-config ~/Repos/personal/nix";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/personal/nix --show-trace";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean all -q";
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
      fh
      nix-fast-build
      nix-btm
      nix-melt
      nix-tree
      httpie
      wishlist
      nix-diff
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
      vhs
      glow
      dua
      lla
      jless
      xcp
      rustscan
      grip-grab
      yq-go
      dogedns
      fastfetch
      ffmpeg_8
      imagemagickBig

      # Nur Packages
      nur.repos.AusCyber.zen-browser
      # Depenencies for Agon
      nodePackages_latest.nodejs
      bun
      cocoapods-beta
      android-studio-tools
      android-tools
      watchman
      fastlane
      zulu17
      php
      php84Packages.composer

      # Homebrew Casks
      brewCasks."android-studio-preview@canary"
      brewCasks."expo-orbit"
      brewCasks."raycast"
      brewCasks."betterdisplay"
      brewCasks."cursor"
      brewCasks."legcord"
      brewCasks."discord@canary"
      brewCasks."dbngin"
      brewCasks."orion"
      brewCasks."cleanshot"
      brewCasks."linearmouse@beta"
      brewCasks."osaurus"
      #brewCasks."nook"
      #brewCasks."helium-browser"
      #brewCasks."tableplus"

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
