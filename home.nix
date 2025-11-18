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
    packages = [
      #Apps
      pkgs.iina
      pkgs.webtorrent_desktop

      #Dev
      pkgs.fh
      #pkgs.nix-direnv
      #pkgs.direnv
      pkgs.nix-fast-build
      pkgs.nix-btm
      pkgs.nix-melt
      pkgs.nix-tree
      pkgs.httpie
      pkgs.wishlist
      pkgs.nix-diff
      pkgs.scc
      pkgs.rainfrog
      pkgs.cursor-cli
      pkgs.hyperfine
      pkgs.php

      #Utilities
      pkgs.rm-improved
      pkgs.dust
      pkgs.duf
      pkgs.vhs
      pkgs.glow
      pkgs.dua
      pkgs.jless
      pkgs.xcp
      pkgs.lla
      pkgs.rustscan
      pkgs.grip-grab
      pkgs.yq-go
      pkgs.dogedns
      pkgs.fastfetch
      pkgs.ffmpeg_8

      # Nur Packages
      pkgs.nur.repos.AusCyber.zen-browser-twilight

      # Homebrew Casks
      pkgs.brewCasks."betterdisplay"
      pkgs.brewCasks."cursor"
      pkgs.brewCasks."tableplus"
      pkgs.brewCasks."raycast"
      pkgs.brewCasks."legcord"
      pkgs.brewCasks."dbngin"
      pkgs.brewCasks."helium-browser"
      pkgs.brewCasks."linearmouse@beta"
      pkgs.brewCasks."cleanshot"
    ];
  };
  imports = [
    ./modules
  ];
}
