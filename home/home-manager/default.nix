{ pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };
  home = {
    stateVersion = "24.05";
    sessionVariables = {
    };
    file = {
    };
    packages = with pkgs; [
      xcp
      rm-improved
      dust
      duf 
      glow
      fd
      uv
      webtorrent_desktop
      nodePackages.webtorrent-cli
      pueue
      nmap
      tree
      rustscan
      fastfetch
      iina
      hvm
    ];
  };
}
