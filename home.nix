{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/nix";
      rebuild-local = "nh home switch -u -q --impure --accept-flake-config ~/Repos/nix";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/nix --show-trace";
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
      jless
      xcp
      rustscan
      grip-grab
      yq-go
      dogedns
      fastfetch
      ffmpeg_8
			betterdisplay
			raycast
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
      brewCasks."android-studio-preview@canary"
      brewCasks."expo-orbit"

      # Homebrew Casks
      brewCasks."cursor"
      brewCasks."legcord"
      brewCasks."discord@canary"
      brewCasks."dbngin"
      brewCasks."orion"
      brewCasks."cleanshot"
      #brewCasks."nook"
      #brewCasks."helium-browser"
      #brewCasks."tableplus"
      #brewCasks."linearmouse@beta"

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
