{pkgs, ...}: {
  home = {
    homeDirectory = "/Users/motheki";
    username = "motheki";
    stateVersion = "25.11";
    sessionVariables = {
    };
    shellAliases = {
      rebuild = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh' -- home switch -u -q --fallback --refresh --impure --accept-flake-config ~/Repos/nix";
      clean = "nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/nh' -- clean user -q";
      manage = "nix --extra-experimental-features 'nix-command flakes' run 'home-manager'  -- switch  --flake ~/Repos/nix --show-trace";
    };
    packages = with pkgs; [
      rm-improved
      iina
      xcp
      webtorrent_desktop
      vhs
      wishlist
      glow
      lla
      duf
      dust
      scc
      fastfetch
      pueue
      ffmpeg_8-full
      hyperfine
      #jujutsu
      #brewCasks."discord"
      #brewCasks."helium-browser"
      #brewCasks."betterdisplay"
      #brewCasks."linearmouse"
      #brewCasks."cleanshot"
      #brewCasks."raycast"
    ];
  };
  imports = [
    ./modules
  ];
}
