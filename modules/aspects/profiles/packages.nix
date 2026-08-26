# Packages without a dedicated Home Manager module. The groups document why a
# package belongs in the user profile without creating overlay indirection.
_: {
  den.aspects.profiles.packages.homeManager = {pkgs, ...}: {
    targets.darwin.copyApps = {
      enable = true;
      directory = "/Users/motheki/Applications";
    };
    home.packages = with pkgs; [
      # Desktop
      webtorrent_desktop

      # Terminal utilities
      act3
      bottom
      chafa
      comma
      dogedns
      dua
      duf
      ffmpeg_9-full
      gftp
      grip-grab
      httpie
      hyperfine
      imagemagickBig
      inetutils
      iina
      jless
      linear
      mdfried
      mosh
      nix-diff
      nix-melt
      nix-tree
      openapi-tui
      radicle-tui
      rainfrog
      rm-improved
      rustscan
      scc
      sd
      vulnix
      watchman
      xcp
      yq-go

      # Mobile development and document tooling
      fastlane
      pdf-cli
      nodejs

      # Applications distributed through Nixpkgs
      orbstack

      # Fonts used by terminal and editor profiles
      nerd-fonts.agave
      nerd-fonts.commit-mono
      nerd-fonts.geist-mono
      nerd-fonts.blex-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
    ];
  };
}
