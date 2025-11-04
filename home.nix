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
    packages = with pkgs; [
      rm-improved
      iina
      xcp
      webtorrent_desktop
      vhs
      wishlist
      glow
      rainfrog
      dua
      jless
      lla
      duf
      dust
      yq-go
      scc
      fastfetch
      pueue
      ffmpeg_8-full
      hyperfine
      brewCasks."legcord"
      brewCasks."helium-browser"
      brewCasks."dbngin"
      brewCasks."betterdisplay"
      brewCasks."linearmouse"
      brewCasks."cleanshot"
      brewCasks."raycast"
    ];
  };
  imports = [
    ./modules
  ];
}
