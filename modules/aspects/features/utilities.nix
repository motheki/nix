# General utilities without dedicated Home Manager modules.
{
  den.aspects.features.utilities.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      act3
      bottom
      chafa
      comma
      dogedns
      dua
      fff-mcp
      duf
      gftp
      grip-grab
      httpie
      hyperfine
      inetutils
      jless
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
    ];
  };
}
