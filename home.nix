{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {
    };
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/nix";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean all -q";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/nix --show-trace";
    };
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
      php
			radicle-tui

      #Utilities
      rm-improved
      dust
      duf
      vhs
      glow
      dua
      jless
      xcp
      lla
      rustscan
      grip-grab
      yq-go
      dogedns
      fastfetch
      ffmpeg_8

      # Nur Packages
      nur.repos.AusCyber.zen-browser-twilight

      # Homebrew Casks
      brewCasks."betterdisplay"
      brewCasks."cursor"
      brewCasks."tableplus"
      brewCasks."raycast"
      brewCasks."legcord"
      brewCasks."dbngin"
      brewCasks."helium-browser"
      brewCasks."linearmouse@beta"
      brewCasks."cleanshot"
    ];
  };
  imports = [
    ./modules
  ];
}
