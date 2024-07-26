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
      "/opt/homebrew/Cellar/"
    ];
    packages = with pkgs; [
      xcp
      rm-improved
      dust
      duf 
      glow
      fd
      curlFull
      uv
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
