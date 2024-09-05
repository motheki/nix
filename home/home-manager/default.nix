{ pkgs, ... }:

{
  programs.home-manager = { enable = true; };
  home = {
    stateVersion = "24.11";
    sessionVariables = { };
    shellAliases = {
    };
    file = { };
    sessionPath = [ "/opt/homebrew/bin" "/opt/homebrew/Cellar/" ];
    packages = with pkgs; [
      xcp
      rm-improved
      dust
      jless
      webtorrent_desktop
      vivid
      duf
      glow
      fd
      curlFull
      pueue
      glab
      nmap
      tree
      rustscan
      fastfetch
      hyperfine
      iina
      zoom-us
    ];
  };
}
