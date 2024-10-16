{pkgs, ...}: {
  programs.home-manager = {enable = true;};
  home = {
    stateVersion = "24.11";
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
      alejandra
      nixpkgs-fmt
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
      zoom-us
    ];
  };
}
