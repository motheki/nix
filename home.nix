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
      pkgs.fh
      pkgs.nix-direnv
      pkgs.duf
      pkgs.nix-output-monitor
      pkgs.nix-fast-build
      pkgs.nix-btm
      pkgs.nix-melt
      pkgs.nix-tree
      pkgs.nix-diff
      pkgs.dust
      pkgs.grip-grab
      pkgs.yq-go
      pkgs.dogedns
      pkgs.scc
      pkgs.cursor-cli
      pkgs.fastfetch
      pkgs.php
      pkgs.ffmpeg_8
      pkgs.hyperfine
      pkgs.nur.repos.AusCyber.zen-browser-twilight
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
