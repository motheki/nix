# General utilities without dedicated Home Manager modules.
{
  den.aspects.features.utilities.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      act3
      chafa
      trash-cli
      comma
      tuios
      dogedns
      mole-cleaner
      dua
      duf
      tailscale
      gftp
      xcp
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
      rm-improved
      rustscan
      scc
      iina
      webtorrent_desktop
      sd
      vulnix
      yq-go
    ];
  };
}
