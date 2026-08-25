# Packages without a dedicated Home Manager module. The groups document why a
# package belongs in the user profile without creating overlay indirection.
_: {
  den.aspects.profiles.packages.homeManager = {pkgs, ...}: {
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
      duckdb
      duf
      ffmpeg_9-full
      gftp
      glow
      grip-grab
      httpie
      hyperfine
      imagemagickBig
      inetutils
      jless
      linear
      mdfried
      mosh
      nix-diff
      nix-melt
      nix-tree
      nixpkgs-reviewFull
      openapi-tui
      radicle-tui
      rainfrog
      rm-improved
      rustscan
      scc
      sd
      tuicr
      vulnix
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
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
    ];
  };
}
