{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {
    };
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- home switch -u -q --impure --accept-flake-config ~/Repos/nix";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh/master' -- clean user -q";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager/master'  -- switch  --flake ~/Repos/nix --show-trace";
    };
    packages = [
      pkgs.rm-improved
      pkgs.iina
      pkgs.xcp
      pkgs.webtorrent_desktop
      pkgs.vhs
      pkgs.wishlist
      pkgs.glow
      pkgs.rainfrog
      pkgs.dua
      pkgs.jless
      pkgs.lla
      pkgs.duf
      pkgs.dust
      pkgs.yq-go
      pkgs.dogedns
      pkgs.scc
      pkgs.cursor-cli
      pkgs.code-cursor
      pkgs.fastfetch
      pkgs.nix-update
      pkgs.pueue
      pkgs.php
      pkgs.ffmpeg_8-full
      pkgs.hyperfine
      pkgs.betterdisplay
      pkgs.tableplus
      pkgs.raycast
      pkgs.nur.repos.AusCyber.zen-browser
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
