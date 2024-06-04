{ pkgs, ... }:

{
  programs.home-manager = {
    enable = true;
  };
  home = {
    stateVersion = "24.11";
    sessionVariables = {
    };
    file = {
    };
    sessionPath = [
      "/opt/homebrew/bin"
    ];
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
      glab
      nmap
      tree
      rustscan
      fastfetch
      iina
    ];
  };
}
