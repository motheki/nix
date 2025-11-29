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
      rebuild-local = "nh home switch -u -q --impure --accept-flake-config ~/Repos/nix";
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
      rustscan
      grip-grab
      yq-go
      dogedns
      fastfetch
      ffmpeg_8
			betterdisplay
			raycast

      # Nur Packages
      nur.repos.AusCyber.zen-browser-twilight

      # Homebrew Casks
      #brewCasks."helium-browser"
      brewCasks."cursor"
      brewCasks."tableplus"
      brewCasks."legcord"
      brewCasks."dbngin"
      brewCasks."orion"
      brewCasks."linearmouse@beta"
      brewCasks."cleanshot"

			#Fonts
			nerd-fonts.commit-mono
    ];
  };
  imports = [
    ./modules
  ];
}
