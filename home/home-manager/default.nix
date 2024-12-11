{pkgs, ...}: {
  programs.home-manager = {enable = true;};
  home = {
    stateVersion = "25.05";
    sessionVariables = {};
    shellAliases = {
    };
    file = {};
    sessionPath = ["/opt/homebrew/bin" "/opt/homebrew/Cellar/"];
    packages = with pkgs; [
      xcp
      rm-improved
      dust
      jless
      webtorrent_desktop
      vivid
      duf
      tarlz
      glow
      fd
      treefmt2
      nodePackages_latest.prettier
      curlFull
      pueue
      glab
      nmap
      tree
      rustscan
      fastfetch
      hyperfine
      iina
      scc
      helix-gpt
    ];
  };
}
